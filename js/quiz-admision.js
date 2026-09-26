/* ============
   SIMULACRO DE ADMISIÓN
   ============= */

const AREAS = REM_ADMISION.areas;
const PAGINA = "test-admision.html";

const SEGUNDOS_POR_PREGUNTA = 45;
const LETRAS = ["A", "B", "C", "D"];

let modo = "gratis";
let preguntas = [];
let actual = 0;
let respuestas = {};
let resultados = null;
let intentoId = null;
let segundos = 0;
let totalSegundos = 0;
let reloj = null;
let seAcaboElTiempo = false;


function mostrarPantalla(cual) {
    $("pantalla_intro").style.display = cual === "intro" ? "" : "none";
    $("pantalla_test").style.display = cual === "test" ? "" : "none";
    $("pantalla_resultados").style.display = cual === "resultados" ? "" : "none";
    window.scrollTo({ top: 0, behavior: "smooth" });
}

async function empezar(nuevoModo) {
    if (nuevoModo === "premium") {
        const resultado = await pedirApi("preguntas-premium.php?test=admision");
        if (!resultado.exito) {
            if (resultado.estado === 401) {
                location.href = `login.html?volver=${encodeURIComponent(PAGINA + "?premium=1")}`;
            } else {
                location.href = "premium.html?test=admision";
            }
            return;
        }
        preguntas = mezclar(resultado.preguntas).map(p => ({ ...p, opciones: mezclar(p.opciones) }));
    } else {
        preguntas = mezclar(REM_ADMISION.preguntas).map(p => ({ ...p, opciones: mezclar(p.opciones) }));
    }

    modo = nuevoModo;
    actual = 0;
    respuestas = {};
    seAcaboElTiempo = false;
    totalSegundos = preguntas.length * SEGUNDOS_POR_PREGUNTA;
    segundos = totalSegundos;

    mostrarPantalla("test");
    pintarPregunta();
    arrancarReloj();
}

function pintarPregunta() {
    const pregunta = preguntas[actual];
    const area = AREAS[pregunta.area];
    const elegida = respuestas[pregunta.id];

    $("contador").textContent = `Pregunta ${actual + 1} de ${preguntas.length}`;
    $("avance").style.width = `${Math.round(actual / preguntas.length * 100)}%`;
    $("etiqueta_area").textContent = area.nombre;
    $("pregunta").textContent = pregunta.texto;

    $("lista_opciones").innerHTML = pregunta.opciones.map((opcion, i) => `
        <button type="button" class="opcion ${elegida === opcion ? "marcada" : ""}" data-valor="${limpiar(opcion)}">
            <span class="letra">${LETRAS[i]}</span><span>${limpiar(opcion)}</span>
        </button>
    `).join("");

    $("lista_opciones").querySelectorAll(".opcion").forEach(boton => {
        boton.addEventListener("click", () => responder(boton.dataset.valor));
    });

    $("btn_anterior").disabled = actual === 0;
    $("btn_siguiente").disabled = !elegida;
    $("btn_siguiente").textContent = actual === preguntas.length - 1 ? "Finalizar simulacro →" : "Siguiente →";
}

function responder(valor) {
    respuestas[preguntas[actual].id] = valor;

    $("lista_opciones").querySelectorAll(".opcion").forEach(boton => {
        boton.classList.toggle("marcada", boton.dataset.valor === valor);
    });

    $("btn_siguiente").disabled = false;
}

function anterior() {
    if (actual > 0) {
        actual--;
        pintarPregunta();
    }
}

function siguiente() {
    if (actual < preguntas.length - 1) {
        actual++;
        pintarPregunta();
    } else {
        terminar();
    }
}


/* ============
   RELOJ
   ============= */

function arrancarReloj() {
    pintarReloj();
    reloj = setInterval(() => {
        segundos--;
        pintarReloj();
        if (segundos <= 0) {
            seAcaboElTiempo = true;
            terminar();
        }
    }, 1000);
}

function pintarReloj() {
    const minutos = Math.floor(segundos / 60);
    const resto = segundos % 60;

    $("cronometro").textContent = `⏱️ ${minutos}:${resto < 10 ? "0" : ""}${resto}`;
    $("cronometro").classList.toggle("poco", segundos <= 60);
}


/* ============
   RESULTADOS
   ============= */

function calcular() {
    const areas = Object.keys(AREAS).map(clave => {
        const delArea = preguntas.filter(p => p.area === clave);
        const buenas = delArea.filter(p => respuestas[p.id] === p.respuesta).length;

        return {
            clave,
            buenas,
            total: delArea.length,
            porcentaje: delArea.length ? Math.round(buenas / delArea.length * 100) : 0,
            ...AREAS[clave]
        };
    });

    const buenas = preguntas.filter(p => respuestas[p.id] === p.respuesta).length;
    const porcentaje = Math.round(buenas / preguntas.length * 100);

    // el puntaje se lleva a la escala de 500 del ICFES solo como referencia
    return { areas, buenas, porcentaje, puntaje: porcentaje * 5 };
}

function nivel(porcentaje) {
    if (porcentaje < 40) return { titulo: "Nivel Bajo", consejo: "Te recomendamos reforzar los conceptos básicos con calma antes de tu examen real. ¡Vas a mejorar con práctica constante!" };
    if (porcentaje < 60) return { titulo: "Nivel Básico", consejo: "Vas por buen camino. Practica un poco más en las áreas con menor puntaje para afianzar lo que te falta." };
    if (porcentaje < 80) return { titulo: "Nivel Alto", consejo: "¡Muy buen resultado! Con algo más de práctica puedes llegar al nivel más alto." };
    return { titulo: "Nivel Muy Alto", consejo: "¡Excelente! Tu preparación luce muy sólida para el examen." };
}

async function terminar() {
    clearInterval(reloj);
    resultados = calcular();
    mostrarPantalla("resultados");
    pintarResultados();

    const guardado = await pedirApi("guardar-intento.php", {
        test: "admision",
        modo,
        totalPreguntas: preguntas.length,
        correctas: resultados.buenas,
        porcentaje: resultados.porcentaje,
        puntaje: resultados.puntaje,
        resumen: encabezado(),
        tiempoSegundos: totalSegundos - Math.max(segundos, 0),
        areas: resultados.areas.map(a => ({ clave: a.clave, nombre: a.nombre, porcentaje: a.porcentaje, correctas: a.buenas, total: a.total })),
        respuestas: preguntas.map(p => ({ pregunta: p.id, area: p.area, respuesta: respuestas[p.id] || null, correcta: respuestas[p.id] === p.respuesta }))
    });
    intentoId = guardado.intentoId || null;
    guardarResultadoSesion();
}

function pintarResultados() {
    const puesto = nivel(resultados.porcentaje);

    $("aviso_tiempo").style.display = seAcaboElTiempo ? "" : "none";

    $("grafico").innerHTML = anilloResultado(resultados.porcentaje, "aciertos");
    $("titulo_resultado").textContent = puesto.titulo;
    $("texto_resultado").textContent = `Respondiste correctamente ${resultados.buenas} de ${preguntas.length} preguntas. ${puesto.consejo}`;
    $("numero_puntaje").textContent = resultados.puntaje;

    $("barras_areas").innerHTML = resultados.areas.map(area => `
        <div class="fila_area">
            <div class="fila_titulo"><span>${area.nombre}</span><span>${area.buenas}/${area.total} · ${area.porcentaje}%</span></div>
            <div class="barra_area"><div class="relleno_area" style="width:${area.porcentaje}%;background:${area.color};"></div></div>
        </div>
    `).join("");

    $("lista_revision").innerHTML = preguntas.map(pregunta => {
        const dada = respuestas[pregunta.id];
        const acerto = dada === pregunta.respuesta;
        const area = AREAS[pregunta.area];

        return `
            <div class="revision ${acerto ? "buena" : "mala"}">
                <div class="rev_area">${area.nombre}</div>
                <div class="rev_pregunta">${limpiar(pregunta.texto)}</div>
                <div class="rev_respuesta">Tu respuesta: <strong>${dada ? limpiar(dada) : "No respondida"}</strong> ${acerto ? "✓" : "✗"}</div>
                ${acerto ? "" : `<div class="rev_respuesta">Respuesta correcta: <strong>${limpiar(pregunta.respuesta)}</strong></div>`}
            </div>`;
    }).join("");

    $("lista_revision").style.display = "none";
    $("btn_revision").textContent = "Ver revisión de respuestas ↓";

    // el cuadro de premium solo tiene sentido si el simulacro se hizo gratis
    $("bloque_premium").style.display = modo === "premium" ? "none" : "";
    $("aviso_informe").classList.remove("visible");
}

function verRevision() {
    const oculta = $("lista_revision").style.display === "none";

    $("lista_revision").style.display = oculta ? "" : "none";
    $("btn_revision").textContent = oculta ? "Ocultar revisión de respuestas ↑" : "Ver revisión de respuestas ↓";
}

function guardarResultadoSesion() {
    sessionStorage.setItem("rem_resultado_admision", JSON.stringify({ modo, preguntas, respuestas, resultados, intentoId, seAcaboElTiempo }));
}

function restaurarResultadoSesion() {
    const guardado = sessionStorage.getItem("rem_resultado_admision");
    if (!guardado) return false;

    ({ modo, preguntas, respuestas, resultados, intentoId, seAcaboElTiempo } = JSON.parse(guardado));
    mostrarPantalla("resultados");
    pintarResultados();
    return true;
}


/* ============
   INFORME
   ============= */

function encabezado() {
    const puesto = nivel(resultados.porcentaje);
    return `Obtuviste ${resultados.porcentaje}% (${resultados.buenas}/${preguntas.length} correctas) — ${puesto.titulo}. Puntaje estimado: ${resultados.puntaje}/500.`;
}

function areasDelInforme() {
    return resultados.areas.map(area => ({ nombre: area.nombre, porcentaje: area.porcentaje, color: colorPlano(area.color) }));
}

function detalleDelInforme() {
    const puesto = nivel(resultados.porcentaje);

    const revision = preguntas.map(pregunta => {
        const dada = respuestas[pregunta.id];
        const acerto = dada === pregunta.respuesta;

        return `<p style="margin:0 0 10px;padding-bottom:10px;border-bottom:1px solid #f1f0f0;">
            <strong>${limpiar(pregunta.texto)}</strong><br>
            Tu respuesta: ${dada ? limpiar(dada) : "No respondida"} ${acerto ? "✓" : "✗"}
            ${acerto ? "" : `<br>Respuesta correcta: ${limpiar(pregunta.respuesta)}`}
        </p>`;
    }).join("");

    return [
        {
            titulo: "Puntaje estimado",
            html: `<p><strong>${resultados.puntaje} / 500</strong> — ${puesto.titulo}. ${puesto.consejo}<br>
                <em>Puntaje de referencia para practicar; no corresponde a una calificación oficial del ICFES.</em></p>`
        },
        { titulo: "Revisión de respuestas", html: revision }
    ];
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

    const html = informeHtml("Simulacro de Admisión REM", usuario, encabezado(), areasDelInforme(), detalleDelInforme());
    const respuesta = await enviarInformePorCorreo("Tu informe del Simulacro de Admisión — REM", html, intentoId);

    avisar(respuesta.exito
        ? " ¡Listo! Te enviamos el informe a tu correo."
        : "No pudimos enviar el correo. Intenta de nuevo en un momento.");
}

async function descargar() {
    const { usuario } = await pedirApi("sesion-actual.php");
    if (!usuario) {
        location.href = `login.html?volver=${encodeURIComponent(PAGINA + "?descargar=1")}`;
        return;
    }

    const html = informeHtml("Simulacro de Admisión REM", usuario, encabezado(), areasDelInforme(), detalleDelInforme());
    const nombre = usuario.nombre.split(" ")[0].toLowerCase();

    descargarInforme(`informe-admision-${nombre}.html`, html);
    avisar(" Tu informe se descargó. Ábrelo en el navegador o imprímelo como PDF.");
}


document.addEventListener("DOMContentLoaded", function () {
    $("btn_gratis").addEventListener("click", () => empezar("gratis"));
    $("btn_premium").addEventListener("click", () => empezar("premium"));
    $("btn_anterior").addEventListener("click", anterior);
    $("btn_siguiente").addEventListener("click", siguiente);
    $("btn_revision").addEventListener("click", verRevision);
    $("btn_activar").addEventListener("click", () => empezar("premium"));
    $("btn_enviar").addEventListener("click", enviarPorCorreo);
    $("btn_descargar").addEventListener("click", descargar);
    $("btn_repetir").addEventListener("click", () => {
        sessionStorage.removeItem("rem_resultado_admision");
        mostrarPantalla("intro");
    });

    const parametros = new URLSearchParams(location.search);

    if (parametros.get("premium") === "1") {
        sessionStorage.removeItem("rem_resultado_admision");
        empezar("premium");
    } else if (restaurarResultadoSesion()) {
        if (parametros.get("enviar") === "1") enviarPorCorreo();
        if (parametros.get("descargar") === "1") descargar();
    }
});
