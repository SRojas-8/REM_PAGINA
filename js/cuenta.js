document.addEventListener("DOMContentLoaded", async function () {
    const resultado = await pedirApi("mi-cuenta.php");

    if (!resultado.exito) {
        $("bloque_sin_sesion").style.display = "";
        return;
    }

    pintarCuenta(resultado);

    if (resultado.usuario.rol === "admin") {
        $("etiqueta_admin").style.display = "";
        $("bloque_admin").style.display = "";
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
                </div>
                <p class="fecha_historial">${fecha}</p>
                <p>${limpiar(intento.resumen)}</p>
                <p class="areas_historial">${limpiar(areas)}</p>
            </div>`;
    }).join("");
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
