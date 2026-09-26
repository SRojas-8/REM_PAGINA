/* ============
   Ajusta lo que cambia según haya o no sesión iniciada:
   el botón del header en todas las páginas, y la tarjeta
   de registro que solo existe en test.html.
   ============= */

document.addEventListener("DOMContentLoaded", async function () {
    try {
        const resultado = await pedirApi("sesion-actual.php");
        if (!resultado.usuario) return;

        const boton = $("btn_unete");
        if (boton) {
            boton.textContent = "Mi cuenta";
            boton.href = "cuenta.html";
        }

        // esto solo está en test.html
        const registrate = $("btn_registrate");
        if (registrate) {
            registrate.textContent = "Ir a mi cuenta";
            registrate.href = "cuenta.html";
            $("titulo_registro").textContent = "Tu cuenta REM";
            $("texto_registro").textContent = "Consulta el historial de tus test y tus resultados cuando quieras.";
        }
    } catch (e) {
        // sin backend conectado todo se queda como está en el HTML
    }
});
