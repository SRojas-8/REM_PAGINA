/* ============
   PANEL DE ADMINISTRADOR — universidades de Educación
   El servidor vuelve a comprobar que seas admin en cada llamada;
   aquí solo se decide qué se muestra.
   ============= */

const CARPETA_ESCUDOS = "img/imgeducacion/Unis/";
const TAMANO_MAX_ESCUDO = 1024 * 1024;
const TIPOS_ESCUDO = ["image/png", "image/jpeg", "image/webp"];

let universidades = [];
let editandoId = null;
let ocupado = false;


function mostrarSinPermiso(titulo, texto, enlace) {
    $("bloque_sin_permiso").style.display = "";
    $("titulo_sin_permiso").textContent = titulo;
    $("texto_sin_permiso").textContent = texto;

    if (enlace) {
        $("enlace_sin_permiso").href = enlace.href;
        $("enlace_sin_permiso").textContent = enlace.texto;
    } else {
        $("enlace_sin_permiso").style.display = "none";
    }
}

async function cargar() {
    const resultado = await pedirApi("admin-universidades.php");

    if (resultado.estado === 401) {
        mostrarSinPermiso("Inicia sesión", "Este panel es solo para administradores.", { href: "login.html?volver=admin.html", texto: "Iniciar sesión" });
        return false;
    }
    if (resultado.estado === 403) {
        mostrarSinPermiso("No tienes permiso", "Este panel es solo para administradores.", { href: "cuenta.html", texto: "Ir a mi cuenta" });
        return false;
    }
    if (!resultado.exito) {
        mostrarSinPermiso("No pudimos cargar el panel", "Intenta de nuevo en un momento.");
        return false;
    }

    universidades = resultado.universidades;
    $("bloque_admin").style.display = "";
    pintarLista();
    return true;
}

function pintarLista() {
    if (!universidades.length) {
        $("lista_universidades").innerHTML = "<p>Todavía no hay universidades. Agrega la primera.</p>";
        return;
    }

    $("lista_universidades").innerHTML = universidades.map((u, i) => {
        const visible = Number(u.activa) === 1;

        return `
            <div class="fila_universidad ${visible ? "" : "oculta"}" data-id="${u.id}">
                <img class="mini_escudo" src="${CARPETA_ESCUDOS}${encodeURIComponent(u.escudo)}" alt="Escudo de ${limpiar(u.nombre)}">
                <div class="datos_universidad">
                    <h4>${limpiar(u.nombre)}</h4>
                    <span class="estado_universidad">${visible ? "Visible" : "Oculta"}</span>
                </div>
                <div class="acciones_universidad">
                    <button type="button" class="btn_mini" data-accion="arriba" title="Subir" aria-label="Subir" ${i === 0 ? "disabled" : ""}>↑</button>
                    <button type="button" class="btn_mini" data-accion="abajo" title="Bajar" aria-label="Bajar" ${i === universidades.length - 1 ? "disabled" : ""}>↓</button>
                    <button type="button" class="btn_mini" data-accion="editar">Editar</button>
                    <button type="button" class="btn_mini" data-accion="visibilidad">${visible ? "Ocultar" : "Mostrar"}</button>
                    <button type="button" class="btn_mini peligro" data-accion="eliminar">Eliminar</button>
                </div>
            </div>`;
    }).join("");
}

function avisar(texto) {
    $("aviso_admin").textContent = texto;
    $("aviso_admin").style.display = "";
}

// manda una acción al servidor como formulario (así puede llevar la imagen)
async function enviar(campos, archivo) {
    const datos = new FormData();
    Object.entries(campos).forEach(([clave, valor]) => datos.append(clave, valor));
    if (archivo) datos.append("escudo", archivo);

    return pedirApiForm("admin-universidades.php", datos);
}

// el bloqueo evita que un doble clic mande la misma acción dos veces
async function ejecutar(campos) {
    if (ocupado) return null;
    ocupado = true;
    $("error_lista").textContent = "";
    $("aviso_admin").style.display = "none";

    try {
        const resultado = await enviar(campos);
        if (!resultado.exito) {
            $("error_lista").textContent = resultado.mensaje || "No se pudo completar la acción.";
            return null;
        }
        await cargar();
        return resultado;
    } catch (e) {
        $("error_lista").textContent = "No se pudo conectar con el servidor.";
        return null;
    } finally {
        ocupado = false;
    }
}

function alHacerClicEnLista(e) {
    const boton = e.target.closest("button[data-accion]");
    if (!boton || boton.disabled) return;

    const id = Number(boton.closest(".fila_universidad").dataset.id);
    const universidad = universidades.find(u => Number(u.id) === id);
    const accion = boton.dataset.accion;

    if (accion === "arriba" || accion === "abajo") {
        ejecutar({ accion: "mover", id, direccion: accion });
    } else if (accion === "visibilidad") {
        ejecutar({ accion: "visibilidad", id });
    } else if (accion === "editar") {
        abrirFormulario(universidad);
    } else if (accion === "eliminar") {
        if (confirm(`¿Eliminar "${universidad.nombre}"? Dejará de aparecer en Educación y no se puede deshacer.\n\nSi solo quieres que no se vea por ahora, usa "Ocultar".`)) {
            ejecutar({ accion: "eliminar", id }).then(r => { if (r) avisar("Universidad eliminada."); });
        }
    }
}


/* ============
   FORMULARIO (crear y editar)
   ============= */

function abrirFormulario(universidad) {
    editandoId = universidad ? Number(universidad.id) : null;

    $("titulo_form").textContent = universidad ? "Editar universidad" : "Agregar universidad";
    $("uni_nombre").value = universidad ? universidad.nombre : "";
    $("uni_url").value = universidad ? universidad.url_oferta : "";
    $("uni_escudo").value = "";
    $("error_form").textContent = "";
    $("aviso_admin").style.display = "none";

    if (universidad) {
        mostrarVista(CARPETA_ESCUDOS + encodeURIComponent(universidad.escudo));
    } else {
        mostrarVista(null);
    }

    $("form_universidad").style.display = "";
    $("uni_nombre").focus();
}

function cerrarFormulario() {
    editandoId = null;
    $("form_universidad").style.display = "none";
    mostrarVista(null);
}

function mostrarVista(src) {
    $("vista_escudo").style.display = src ? "" : "none";
    if (src) {
        $("vista_escudo").src = src;
    } else {
        $("vista_escudo").removeAttribute("src");
    }
}

function alElegirImagen() {
    const archivo = $("uni_escudo").files[0];
    if (archivo) mostrarVista(URL.createObjectURL(archivo));
}

// estas comprobaciones solo ahorran un viaje al servidor; el servidor las repite
function validarFormulario(archivo) {
    if (!$("uni_nombre").value.trim()) return "Escribe el nombre de la universidad.";
    if (!/^https?:\/\/\S+$/i.test($("uni_url").value.trim())) return "El enlace debe empezar por http:// o https://";
    if (!editandoId && !archivo) return "Elige el escudo de la universidad.";
    if (archivo && !TIPOS_ESCUDO.includes(archivo.type)) return "El escudo debe ser una imagen PNG, JPG o WEBP.";
    if (archivo && archivo.size > TAMANO_MAX_ESCUDO) return "La imagen es demasiado grande (máximo 1 MB).";
    return "";
}

async function guardar(e) {
    e.preventDefault();
    if (ocupado) return;

    const archivo = $("uni_escudo").files[0] || null;
    const problema = validarFormulario(archivo);
    if (problema) {
        $("error_form").textContent = problema;
        return;
    }

    ocupado = true;
    $("btn_guardar").disabled = true;
    $("error_form").textContent = "";

    try {
        const campos = {
            accion: editandoId ? "editar" : "crear",
            nombre: $("uni_nombre").value.trim(),
            url_oferta: $("uni_url").value.trim()
        };
        if (editandoId) campos.id = editandoId;

        const resultado = await enviar(campos, archivo);
        if (!resultado.exito) {
            $("error_form").textContent = resultado.mensaje || "No se pudo guardar.";
            return;
        }

        const eraNueva = !editandoId;
        cerrarFormulario();
        await cargar();
        avisar(eraNueva ? "Universidad agregada al final de la lista." : "Cambios guardados.");
    } catch (e) {
        $("error_form").textContent = "No se pudo conectar con el servidor.";
    } finally {
        ocupado = false;
        $("btn_guardar").disabled = false;
    }
}


document.addEventListener("DOMContentLoaded", async function () {
    $("btn_agregar").addEventListener("click", () => abrirFormulario(null));
    $("btn_cancelar").addEventListener("click", cerrarFormulario);
    $("form_universidad").addEventListener("submit", guardar);
    $("uni_escudo").addEventListener("change", alElegirImagen);
    $("lista_universidades").addEventListener("click", alHacerClicEnLista);

    try {
        await cargar();
    } catch (e) {
        mostrarSinPermiso("No pudimos cargar el panel", "Intenta de nuevo en un momento.");
    }
});
