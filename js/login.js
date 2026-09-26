document.addEventListener("DOMContentLoaded", function () {
    $("form_login").addEventListener("submit", async function (e) {
        e.preventDefault();

        const correo = $("campo_correo").value.trim();
        const clave = $("campo_clave").value;
        const error = $("mensaje_error");

        if (!correoValido(correo) || !clave) {
            error.textContent = "Escribe tu correo y tu contraseña.";
            return;
        }

        error.textContent = "";
        $("btn_entrar").disabled = true;
        $("btn_entrar").textContent = "Entrando...";

        const resultado = await pedirApi("iniciar-sesion.php", { correo, clave });

        if (!resultado.exito) {
            error.textContent = resultado.mensaje || "No se pudo iniciar sesión.";
            $("btn_entrar").disabled = false;
            $("btn_entrar").textContent = "Iniciar sesión";
            return;
        }

        const parametros = new URLSearchParams(location.search);
        location.href = parametros.get("volver") || "cuenta.html";
    });

    const volver = new URLSearchParams(location.search).get("volver");
    if (volver) {
        $("aviso_volver").style.display = "";
        $("enlace_registro").href = `registro.html?volver=${encodeURIComponent(volver)}`;
    }
});
