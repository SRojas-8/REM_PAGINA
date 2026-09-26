const NOMBRES_TEST = { vocacional: "Test Vocacional", admision: "Simulacro de Admisión" };
const PAGINA_TEST = { vocacional: "test-vocacional.html", admision: "test-admision.html" };

document.addEventListener("DOMContentLoaded", async function () {
    const test = new URLSearchParams(location.search).get("test");

    if (!NOMBRES_TEST[test]) {
        location.href = "test.html";
        return;
    }

    const sesion = await pedirApi("sesion-actual.php");
    if (!sesion.usuario) {
        location.href = `login.html?volver=${encodeURIComponent(`premium.html?test=${test}`)}`;
        return;
    }

    $("nombre_test").textContent = NOMBRES_TEST[test];

    const solicitud = await pedirApi("solicitar-premium.php", { test });

    if (solicitud.yaTieneAcceso) {
        $("bloque_pago").style.display = "none";
        $("bloque_listo").style.display = "";
        $("btn_ir_al_test").href = PAGINA_TEST[test];
        return;
    }

    if (!solicitud.exito) {
        $("mensaje_error_pago").textContent = solicitud.mensaje || "No pudimos generar tu solicitud. Intenta de nuevo.";
        return;
    }

    $("nequi_numero").textContent = solicitud.nequiNumero;
    $("nequi_titular").textContent = solicitud.nequiTitular;
    $("valor_pago").textContent = `$${Number(solicitud.valor).toLocaleString("es-CO")}`;
    $("referencia_pago").textContent = solicitud.referencia;

    const mensaje = encodeURIComponent(
        `Hola REM 🎓, ya pagué el ${NOMBRES_TEST[test]} Premium. Referencia: ${solicitud.referencia}. Te comparto el comprobante:`
    );
    $("link_whatsapp").href = `https://wa.me/${REM_CONFIG.contacto.whatsapp}?text=${mensaje}`;

    $("form_codigo").addEventListener("submit", async function (e) {
        e.preventDefault();
        const codigo = $("campo_codigo").value.trim();
        const error = $("mensaje_error");

        if (!codigo) {
            error.textContent = "Escribe el código que te enviamos por correo.";
            return;
        }

        error.textContent = "";
        $("btn_canjear").disabled = true;
        $("btn_canjear").textContent = "Verificando...";

        const resultado = await pedirApi("canjear-codigo.php", { test, codigo });

        if (!resultado.exito) {
            error.textContent = resultado.mensaje || "No se pudo activar el código.";
            $("btn_canjear").disabled = false;
            $("btn_canjear").textContent = "Activar Premium";
            return;
        }

        location.href = `${PAGINA_TEST[test]}?premium=1`;
    });
});
