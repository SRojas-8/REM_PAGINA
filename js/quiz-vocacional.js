/* ============
   TEST VOCACIONAL
   ============= */

const AREAS = REM_VOCACIONAL.areas;
const PAGINA = "test-vocacional.html";

const ESCALA = ["Nada de acuerdo", "Poco de acuerdo", "Algo de acuerdo", "Bastante de acuerdo", "Totalmente de acuerdo"];

let modo = "gratis";
let preguntas = [];
let actual = 0;
let respuestas = {};
let resultados = [];
let intentoId = null;


function mostrarPantalla(cual) {
    $("pantalla_intro").style.display = cual === "intro" ? "" : "none";
    $("pantalla_test").style.display = cual === "test" ? "" : "none";
    $("pantalla_resultados").style.display = cual === "resultados" ? "" : "none";
    window.scrollTo({ top: 0, behavior: "smooth" });
}

async function empezar(nuevoModo) {
    if (nuevoModo === "premium") {
        const resultado = await pedirApi("preguntas-premium.php?test=vocacional");
        if (!resultado.exito) {
            if (resultado.estado === 401) {
                location.href = `login.html?volver=${encodeURIComponent(PAGINA + "?premium=1")}`;
            } else {
                location.href = "premium.html?test=vocacional";
            }
            return;
        }
        preguntas = mezclar(resultado.preguntas);
    } else {
        preguntas = mezclar(REM_VOCACIONAL.preguntas);
    }

    modo = nuevoModo;
    actual = 0;
    respuestas = {};

    mostrarPantalla("test");
    pintarPregunta();
}

function pintarPregunta() {
    const pregunta = preguntas[actual];
    const elegida = respuestas[pregunta.id];

    $("contador").textContent = `Pregunta ${actual + 1} de ${preguntas.length}`;
    $("avance").style.width = `${Math.round(actual / preguntas.length * 100)}%`;
    $("pregunta").textContent = pregunta.texto;

    $("fila_escala").innerHTML = ESCALA.map((titulo, i) => `
        <button type="button" class="opcion_escala ${elegida === i + 1 ? "marcada" : ""}" data-valor="${i + 1}">
            <span class="punto"></span>${titulo}
        </button>
    `).join("");

    $("fila_escala").querySelectorAll(".opcion_escala").forEach(boton => {
        boton.addEventListener("click", () => responder(Number(boton.dataset.valor)));
    });

    $("btn_anterior").disabled = actual === 0;
}

function responder(valor) {
    respuestas[preguntas[actual].id] = valor;

    $("fila_escala").querySelectorAll(".opcion_escala").forEach(boton => {
        boton.classList.toggle("marcada", Number(boton.dataset.valor) === valor);
    });

    // una pausita para que se alcance a ver la opción marcada antes de pasar
    setTimeout(() => {
        if (actual < preguntas.length - 1) {
            actual++;
            pintarPregunta();
        } else {
            terminar();
        }
    }, 320);
}

function anterior() {
    if (actual > 0) {
        actual--;
        pintarPregunta();
    }
}

/* cada área se puntúa sobre el máximo posible de sus preguntas (5 por afirmación) */
function calcular() {
    return Object.keys(AREAS).map(clave => {
        const delArea = preguntas.filter(p => p.area === clave);
        const suma = delArea.reduce((total, p) => total + (respuestas[p.id] || 0), 0);
        const maximo = delArea.length * 5;

        return { clave, porcentaje: maximo ? Math.round(suma / maximo * 100) : 0, ...AREAS[clave] };
    }).sort((a, b) => b.porcentaje - a.porcentaje);
}

async function terminar() {
    resultados = calcular();
    mostrarPantalla("resultados");
    pintarResultados();

    const guardado = await pedirApi("guardar-intento.php", {
        test: "vocacional",
        modo,
        totalPreguntas: preguntas.length,
        correctas: 0,
        porcentaje: resultados[0].porcentaje,
        resumen: encabezado(),
        areas: resultados.map(a => ({ clave: a.clave, nombre: a.nombre, porcentaje: a.porcentaje })),
        respuestas: preguntas.filter(p => respuestas[p.id]).map(p => ({ pregunta: p.id, area: p.area, valor: respuestas[p.id] }))
    });
    intentoId = guardado.intentoId || null;
    guardarResultadoSesion();
}

function pintarResultados() {
    const mejor = resultados[0];
    const cuantas = modo === "premium" ? 3 : 1;

    $("grafico").innerHTML = anilloResultado(mejor.porcentaje, "afinidad");
    $("titulo_resultado").textContent = mejor.nombre;
    $("texto_resultado").textContent = mejor.texto;

    $("barras_areas").innerHTML = resultados.map(area => `
        <div class="fila_area">
            <div class="fila_titulo"><span>${area.nombre}</span><span>${area.porcentaje}%</span></div>
            <div class="barra_area"><div class="relleno_area" style="width:${area.porcentaje}%;background:${area.color};"></div></div>
        </div>
    `).join("");

    $("detalle_areas").innerHTML = resultados.slice(0, cuantas).map(area => `
        <div class="detalle_area">
            <h4>${area.nombre} — ${area.porcentaje}% de afinidad</h4>
            <p>${area.texto}</p>
            <div class="carreras">${area.carreras.map(c => `<span class="carrera">${c}</span>`).join("")}</div>
        </div>
    `).join("") + `
        <p class="nota_areas">Análisis basado en tus ${preguntas.length} respuestas.
        <a href="pregrados.html">Ver programas relacionados en Pregrados →</a></p>`;

    // el cuadro de premium solo tiene sentido si el test se hizo gratis
    $("bloque_premium").style.display = modo === "premium" ? "none" : "";
    $("aviso_informe").classList.remove("visible");
}

function guardarResultadoSesion() {
    sessionStorage.setItem("rem_resultado_vocacional", JSON.stringify({ modo, preguntas, respuestas, resultados, intentoId }));
}

function restaurarResultadoSesion() {
    const guardado = sessionStorage.getItem("rem_resultado_vocacional");
    if (!guardado) return false;

    ({ modo, preguntas, respuestas, resultados, intentoId } = JSON.parse(guardado));
    mostrarPantalla("resultados");
    pintarResultados();
    return true;
}


/* ============
   INFORME
   ============= */

function encabezado() {
    return `Tu perfil vocacional predominante es ${resultados[0].nombre} (${resultados[0].porcentaje}% de afinidad).`;
}

function areasDelInforme() {
    return resultados.map(area => ({ nombre: area.nombre, porcentaje: area.porcentaje, color: colorPlano(area.color) }));
}

function detalleDelInforme() {
    const cuantas = modo === "premium" ? 3 : 1;

    return [{
        titulo: cuantas > 1 ? "Tus áreas más afines" : "Tu área principal",
        html: resultados.slice(0, cuantas).map(area =>
            `<p><strong>${area.nombre}</strong> — ${area.porcentaje}%<br>${area.texto}<br>
            <em>Carreras sugeridas: ${area.carreras.join(", ")}</em></p>`
        ).join("")
    }];
}

function avisar(texto) {
    $("aviso_informe").textContent = texto;
    $("aviso_informe").classList.add("visible");
}

async function enviarPorCorreo() {
    const { usuario } = await pedirApi("sesion-actual.php");
    if (!usuario) {
        location.href = `login.html?volver=${encodeURIComponent(PAGINA + "?enviar=1")}`;
        return;
    }

    const html = informeHtml("Test Vocacional REM", usuario, encabezado(), areasDelInforme(), detalleDelInforme());
    const respuesta = await enviarInformePorCorreo("Tu informe del Test Vocacional — REM", html, intentoId);

    avisar(respuesta.exito
        ? "✅ ¡Listo! Te enviamos el informe a tu correo."
        : "No pudimos enviar el correo. Intenta de nuevo en un momento.");
}

async function descargar() {
    const { usuario } = await pedirApi("sesion-actual.php");
    if (!usuario) {
        location.href = `login.html?volver=${encodeURIComponent(PAGINA + "?descargar=1")}`;
        return;
    }

    const html = informeHtml("Test Vocacional REM", usuario, encabezado(), areasDelInforme(), detalleDelInforme());
    const nombre = usuario.nombre.split(" ")[0].toLowerCase();

    descargarInforme(`informe-vocacional-${nombre}.html`, html);
    avisar("✅ Tu informe se descargó. Ábrelo en el navegador o imprímelo como PDF.");
}


document.addEventListener("DOMContentLoaded", function () {
    $("btn_gratis").addEventListener("click", () => empezar("gratis"));
    $("btn_premium").addEventListener("click", () => empezar("premium"));
    $("btn_anterior").addEventListener("click", anterior);
    $("btn_activar").addEventListener("click", () => empezar("premium"));
    $("btn_enviar").addEventListener("click", enviarPorCorreo);
    $("btn_descargar").addEventListener("click", descargar);
    $("btn_repetir").addEventListener("click", () => {
        sessionStorage.removeItem("rem_resultado_vocacional");
        mostrarPantalla("intro");
    });

    const parametros = new URLSearchParams(location.search);

    if (parametros.get("premium") === "1") {
        sessionStorage.removeItem("rem_resultado_vocacional");
        empezar("premium");
    } else if (restaurarResultadoSesion()) {
        if (parametros.get("enviar") === "1") enviarPorCorreo();
        if (parametros.get("descargar") === "1") descargar();
    }
});
