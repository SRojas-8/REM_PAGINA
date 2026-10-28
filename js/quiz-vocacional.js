/* ============
   TEST VOCACIONAL
   ============= */

const AREAS = REM_VOCACIONAL.areas;
const PAGINA = "test-vocacional.html";

const ESCALA = ["Nada de acuerdo", "Poco de acuerdo", "Algo de acuerdo", "Bastante de acuerdo", "Totalmente de acuerdo"];

const TOP_AREAS = 3;

let preguntas = [];
let actual = 0;
let respuestas = {};
let resultados = [];
let intentoId = null;


function mostrarPantalla(cual) {
    $("pantalla_test").style.display = cual === "test" ? "" : "none";
    $("pantalla_resultados").style.display = cual === "resultados" ? "" : "none";
    window.scrollTo({ top: 0, behavior: "smooth" });
}

async function empezar() {
    mostrarPantalla("test");
    $("contador").textContent = "";
    $("avance").style.width = "0%";
    $("btn_anterior").disabled = true;
    $("pregunta").textContent = "Cargando preguntas...";
    $("fila_escala").innerHTML = "";
    $("btn_reintentar").style.display = "none";

    let resultado;
    try {
        resultado = await pedirApi("preguntas.php?test=vocacional");
    } catch (error) {
        resultado = { exito: false };
    }

    if (!resultado.exito) {
        $("pregunta").textContent = "No pudimos cargar las preguntas. Revisa tu conexión e intenta de nuevo.";
        $("btn_reintentar").style.display = "";
        return;
    }

    preguntas = mezclar(resultado.preguntas);
    actual = 0;
    respuestas = {};

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
    $("grafico").innerHTML = anilloResultado(mejor.porcentaje, "afinidad");
    $("titulo_resultado").textContent = mejor.nombre;
    $("texto_resultado").textContent = mejor.texto;

    $("barras_areas").innerHTML = resultados.map(area => `
        <div class="fila_area">
            <div class="fila_titulo"><span>${area.nombre}</span><span>${area.porcentaje}%</span></div>
            <div class="barra_area"><div class="relleno_area" style="width:${area.porcentaje}%;background:${area.color};"></div></div>
        </div>
    `).join("");

    $("detalle_areas").innerHTML = resultados.slice(0, TOP_AREAS).map(area => `
        <div class="detalle_area">
            <h4>${area.nombre} — ${area.porcentaje}% de afinidad</h4>
            <p>${area.texto}</p>
            <div class="carreras">${area.carreras.map(c => `<span class="carrera">${c}</span>`).join("")}</div>
        </div>
    `).join("") + `
        <p class="nota_areas">Análisis basado en tus ${preguntas.length} respuestas.
        <a href="educacion.html">Ver programas relacionados en Educación →</a></p>`;

    $("aviso_informe").classList.remove("visible");
}

function guardarResultadoSesion() {
    sessionStorage.setItem("rem_resultado_vocacional", JSON.stringify({ preguntas, respuestas, resultados, intentoId }));
}

function restaurarResultadoSesion() {
    const guardado = sessionStorage.getItem("rem_resultado_vocacional");
    if (!guardado) return false;

    ({ preguntas, respuestas, resultados, intentoId } = JSON.parse(guardado));
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
    return [{
        titulo: "Tus áreas más afines",
        html: resultados.slice(0, TOP_AREAS).map(area =>
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
    $("btn_anterior").addEventListener("click", anterior);
    $("btn_reintentar").addEventListener("click", empezar);
    $("btn_enviar").addEventListener("click", enviarPorCorreo);
    $("btn_descargar").addEventListener("click", descargar);
    $("btn_repetir").addEventListener("click", () => {
        sessionStorage.removeItem("rem_resultado_vocacional");
        empezar();
    });

    // el resultado guardado solo se recupera al volver del login para
    // enviar o descargar el informe; en cualquier otro caso es un test nuevo
    const parametros = new URLSearchParams(location.search);
    const vuelveDelLogin = parametros.get("enviar") === "1" || parametros.get("descargar") === "1";

    if (vuelveDelLogin && restaurarResultadoSesion()) {
        if (parametros.get("enviar") === "1") enviarPorCorreo();
        if (parametros.get("descargar") === "1") descargar();
    } else {
        sessionStorage.removeItem("rem_resultado_vocacional");
        empezar();
    }
});
