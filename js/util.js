/* ============
   Ayudas que usan todas las páginas del sitio (test, cuenta,
   login, registro, premium y el panel de administrador).
   ============= */

window.REM_CONFIG = {
    contacto: {
        correo: "remuniversidades@gmail.com",
        whatsapp: "573228540721"
    }
};

function $(id) {
    return document.getElementById(id);
}

function mezclar(lista) {
    const copia = lista.slice();
    for (let i = copia.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [copia[i], copia[j]] = [copia[j], copia[i]];
    }
    return copia;
}

function limpiar(texto) {
    const caja = document.createElement("div");
    caja.textContent = texto == null ? "" : texto;
    return caja.innerHTML;
}

function correoValido(correo) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo);
}

function fechaDeHoy() {
    return new Date().toLocaleDateString("es-CO", { day: "numeric", month: "long", year: "numeric" });
}

// llama a la API de REM. Sin "datos" hace un GET, con "datos" hace un POST con ese cuerpo.
// Siempre manda la cookie de sesión para que el servidor sepa quién eres.
async function pedirApi(ruta, datos) {
    const opciones = { credentials: "include" };
    if (datos) {
        opciones.method = "POST";
        opciones.headers = { "Content-Type": "application/json" };
        opciones.body = JSON.stringify(datos);
    }
    const respuesta = await fetch(`api/${ruta}`, opciones);
    const cuerpo = await respuesta.json();
    cuerpo.estado = respuesta.status;
    return cuerpo;
}
