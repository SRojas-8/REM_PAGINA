document.addEventListener("DOMContentLoaded", function () {
    $("form_registro").addEventListener("submit", async function (e) {
        e.preventDefault();

        const nombre = $("campo_nombre").value.trim();
        const apellido = $("campo_apellido").value.trim();
        const correo = $("campo_correo").value.trim();
        const telefono = $("campo_telefono").value.trim();
        const clave = $("campo_clave").value;
        const confirmar = $("campo_confirmar").value;
        const error = $("mensaje_error");

        if (!nombre || !apellido) {
            error.textContent = "Escribe tu nombre y tu apellido.";
            return;
        }
        if (!correoValido(correo)) {
            error.textContent = "Escribe un correo electrónico válido.";
            return;
        }
        if (clave.length < 6) {
            error.textContent = "La contraseña debe tener mínimo 6 caracteres.";
            return;
        }
        if (clave !== confirmar) {
            error.textContent = "Las contraseñas no coinciden.";
            return;
        }

        error.textContent = "";
        $("aviso_correo").style.display = "none";
        $("btn_registrar").disabled = true;
        $("btn_registrar").textContent = "Creando cuenta...";

        const resultado = await pedirApi("registrar.php", { nombre, apellido, correo, telefono, clave });

        if (!resultado.exito) {
            if (resultado.correoExiste) {
                // este caso se avisa en grande y con el enlace para entrar de una
                $("aviso_correo").innerHTML = `${limpiar(resultado.mensaje)} <a href="${enlaceLogin()}">Inicia sesión →</a>`;
                $("aviso_correo").style.display = "";
            } else {
                error.textContent = resultado.mensaje || "No se pudo crear la cuenta.";
            }
            $("btn_registrar").disabled = false;
            $("btn_registrar").textContent = "Crear mi cuenta";
            return;
        }

        const parametros = new URLSearchParams(location.search);
        location.href = parametros.get("volver") || "cuenta.html";
    });

    const volver = new URLSearchParams(location.search).get("volver");
    if (volver) {
        $("enlace_login").href = enlaceLogin();
    }
});

// conserva el ?volver= si la persona llegó aquí desde otra página
function enlaceLogin() {
    const volver = new URLSearchParams(location.search).get("volver");
    return volver ? `login.html?volver=${encodeURIComponent(volver)}` : "login.html";
}
