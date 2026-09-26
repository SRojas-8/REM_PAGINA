document.addEventListener("DOMContentLoaded", async function () {
    const resultado = await pedirApi("mi-cuenta.php");

    if (!resultado.exito) {
        $("bloque_sin_sesion").style.display = "";
        return;
    }

    pintarCuenta(resultado);

    // el panel de solicitudes solo aparece si la cuenta es de administrador.
    // De todos modos el servidor vuelve a revisar el rol en cada llamada a admin-solicitudes.php
    if (resultado.usuario.rol === "admin") {
        $("etiqueta_admin").style.display = "";
        $("bloque_admin").style.display = "";
        cargarSolicitudes();
    }

    $("btn_cerrar_sesion").addEventListener("click", async () => {
        await pedirApi("cerrar-sesion.php", {});
        location.href = "index.html";
    });

    $("form_perfil").addEventListener("submit", guardarPerfil);
    $("form_eliminar").addEventListener("submit", eliminarCuenta);
});

function pintarCuenta({ usuario, intentos }) {
    $("bloque_cuenta").style.display = "";
    $("nombre_cuenta").textContent = `${usuario.nombre} ${usuario.apellido}`;
    $("correo_cuenta").textContent = usuario.correo;

    $("perfil_nombre").value = usuario.nombre;
    $("perfil_apellido").value = usuario.apellido;
    $("perfil_telefono").value = usuario.telefono;

    if (!intentos.length) {
        $("historial").innerHTML = '<p>Todavía no has hecho ningún test. <a href="test.html">Empieza aquí →</a></p>';
        return;
    }

    $("historial").innerHTML = intentos.map(intento => {
        const areas = intento.areas.slice(0, 3).map(a => `${a.area_nombre} ${a.porcentaje}%`).join(" · ");
        const fecha = new Date(intento.fecha).toLocaleDateString("es-CO", { day: "numeric", month: "long", year: "numeric" });

        return `
            <div class="fila_historial">
                <div class="cabeza_historial">
                    <h4>${limpiar(intento.test_nombre)}</h4>
                    <span class="etiqueta_modo ${intento.modo}">${intento.modo === "premium" ? "Premium" : "Gratis"}</span>
                </div>
                <p class="fecha_historial">${fecha}</p>
                <p>${limpiar(intento.resumen)}</p>
                <p class="areas_historial">${limpiar(areas)}</p>
            </div>`;
    }).join("");
}


/* ============
   SOLICITUDES PREMIUM (solo administradores)
   ============= */

async function cargarSolicitudes() {
    const resultado = await pedirApi("admin-solicitudes.php");
    if (!resultado.exito) return;

    const pendientes = resultado.solicitudes.filter(s => s.estado === "pendiente");
    const procesadas = resultado.solicitudes.filter(s => s.estado !== "pendiente");

    $("solicitudes_pendientes").innerHTML = pendientes.length
        ? pendientes.map(s => fichaSolicitud(s, false)).join("")
        : "<p>No hay solicitudes pendientes.</p>";

    $("titulo_procesadas").style.display = procesadas.length ? "" : "none";
    $("solicitudes_procesadas").innerHTML = procesadas.map(s => fichaSolicitud(s, true)).join("");

    $("solicitudes_pendientes").querySelectorAll(".fila_solicitud").forEach(fila => {
        fila.querySelectorAll("button").forEach(boton => {
            boton.addEventListener("click", () => procesar(Number(fila.dataset.id), boton.dataset.accion, fila));
        });
    });
}

function fichaSolicitud(s, procesada) {
    return `
        <div class="fila_solicitud ${procesada ? "procesada" : ""}" data-id="${s.id}">
            <div>
                <h4>${limpiar(s.nombre)} ${limpiar(s.apellido)} — ${limpiar(s.test_nombre)}</h4>
                <p>${limpiar(s.correo)} · ${limpiar(s.telefono)}</p>
                <p>Ref. ${limpiar(s.referencia)} · $${Number(s.valor).toLocaleString("es-CO")} · ${limpiar(s.estado)}</p>
            </div>
            ${procesada ? "" : `
                <div class="acciones_solicitud">
                    <button type="button" class="btn_principal" data-accion="confirmar">Confirmar</button>
                    <button type="button" class="btn_borde" data-accion="rechazar">Rechazar</button>
                </div>`}
        </div>`;
}

async function procesar(id, accion, fila) {
    fila.querySelectorAll("button").forEach(b => b.disabled = true);

    const resultado = await pedirApi("admin-solicitudes.php", { id, accion });

    if (!resultado.exito) {
        alert(resultado.mensaje || "No se pudo procesar la solicitud.");
        fila.querySelectorAll("button").forEach(b => b.disabled = false);
        return;
    }

    cargarSolicitudes();
}


/* ============
   EDITAR PERFIL / ELIMINAR CUENTA
   ============= */

async function guardarPerfil(e) {
    e.preventDefault();

    const nombre = $("perfil_nombre").value.trim();
    const apellido = $("perfil_apellido").value.trim();
    const telefono = $("perfil_telefono").value.trim();
    const claveActual = $("perfil_clave_actual").value;
    const claveNueva = $("perfil_clave_nueva").value;
    const error = $("error_perfil");

    error.textContent = "";
    $("aviso_perfil_ok").style.display = "none";
    $("btn_guardar_perfil").disabled = true;

    const resultado = await pedirApi("actualizar-perfil.php", { nombre, apellido, telefono, claveActual, claveNueva });

    $("btn_guardar_perfil").disabled = false;

    if (!resultado.exito) {
        error.textContent = resultado.mensaje || "No se pudo guardar el cambio.";
        return;
    }

    $("nombre_cuenta").textContent = `${resultado.usuario.nombre} ${resultado.usuario.apellido}`;
    $("perfil_clave_actual").value = "";
    $("perfil_clave_nueva").value = "";
    $("aviso_perfil_ok").textContent = " Tus datos se guardaron.";
    $("aviso_perfil_ok").style.display = "";
}

async function eliminarCuenta(e) {
    e.preventDefault();

    const clave = $("eliminar_clave").value;
    const error = $("error_eliminar");

    if (!confirm("¿Seguro que quieres eliminar tu cuenta? Esto no se puede deshacer.")) {
        return;
    }

    error.textContent = "";
    $("btn_eliminar_cuenta").disabled = true;

    const resultado = await pedirApi("eliminar-cuenta.php", { clave });

    if (!resultado.exito) {
        error.textContent = resultado.mensaje || "No se pudo eliminar la cuenta.";
        $("btn_eliminar_cuenta").disabled = false;
        return;
    }

    location.href = "index.html";
}
