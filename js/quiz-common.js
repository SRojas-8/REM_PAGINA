/* ============
   Lo que comparten el test vocacional y el simulacro de admisión:
   armar el informe (para descargar o para que lo mande el
   servidor) y el anillo de resultados. Necesita que la página
   también cargue js/util.js antes que este archivo.
   ============= */

const COLORES = {
    "var(--celeste)": "#377681",
    "var(--verde_apagado)": "#3f5f3f",
    "var(--celeste_apagado)": "#92c1ca",
    "var(--cian)": "#c1e3e6",
    "var(--celeste_apagadito)": "#a0bcc2"
};

// en el informe los colores van fijos porque las variables del CSS no viajan en el correo
function colorPlano(color) {
    return COLORES[color] || "#377681";
}

/* ============
   INFORME
   ============= */

/* versión en HTML, la que se descarga y la que se envía por correo;
   lleva los estilos adentro para que se vea igual en cualquier lado */
function informeHtml(titulo, usuario, encabezado, areas, secciones) {
    const barras = areas.map(area => `
            <div style="margin-bottom:14px;">
                <div style="display:flex;justify-content:space-between;font-size:14px;font-weight:700;margin-bottom:4px;">
                    <span>${limpiar(area.nombre)}</span><span>${area.porcentaje}%</span>
                </div>
                <div style="height:12px;background:#f1f0f0;border-radius:999px;overflow:hidden;">
                    <div style="height:100%;width:${area.porcentaje}%;background:${area.color};border-radius:999px;"></div>
                </div>
            </div>`).join("");

    const extra = secciones.map(seccion => `
            <div style="margin-top:22px;">
                <h3 style="font-size:16px;margin-bottom:8px;color:#377681;">${seccion.titulo}</h3>
                <div style="font-size:14px;line-height:1.6;">${seccion.html}</div>
            </div>`).join("");

    return `<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${titulo} — Informe REM</title>
</head>
<body style="font-family:Georgia,'Times New Roman',serif;background:#dbf6f8;margin:0;padding:40px 16px;color:#000;">
  <div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:24px;overflow:hidden;box-shadow:0 10px 30px rgba(0,0,0,0.12);">
    <div style="background:linear-gradient(135deg,#377681,#92c1ca);color:#fff;padding:34px 36px;">
      <div style="font-size:12px;letter-spacing:0.08em;text-transform:uppercase;opacity:0.85;margin-bottom:6px;">Red Educativa Medellín</div>
      <h1 style="margin:0 0 8px;font-size:26px;">${titulo}</h1>
      <div style="font-size:13px;opacity:0.9;">${fechaDeHoy()} · Informe para ${limpiar(usuario.nombre)}</div>
    </div>
    <div style="padding:34px 36px;">
      <p style="font-size:16px;line-height:1.6;font-weight:700;margin-top:0;">${encabezado}</p>
      <h3 style="font-size:16px;margin:26px 0 14px;color:#377681;">Resultados por área</h3>
      ${barras}
      ${extra}
      <div style="margin-top:32px;padding-top:20px;border-top:1px solid #f1f0f0;font-size:12px;color:#777;line-height:1.6;">
        Este informe se generó con tus respuestas en rem-universidades.co y tiene fines orientativos.<br>
        ¿Dudas? Escríbenos a remuniversidades@gmail.com o al (604) 4725811.
      </div>
    </div>
  </div>
</body>
</html>`;
}

function descargarInforme(archivo, html) {
    const enlace = document.createElement("a");
    enlace.href = URL.createObjectURL(new Blob([html], { type: "text/html;charset=utf-8" }));
    enlace.download = archivo;
    enlace.click();
    setTimeout(() => URL.revokeObjectURL(enlace.href), 4000);
}

// pide al servidor que mande el informe por correo desde remuniversidades@gmail.com
async function enviarInformePorCorreo(asunto, html, intentoId) {
    return pedirApi("enviar-informe.php", { asunto, html, intentoId });
}

/* ============
   ANILLO DE RESULTADOS
   ============= */

function anilloResultado(porcentaje, etiqueta) {
    const tamano = 148;
    const grosor = 14;
    const radio = (tamano - grosor) / 2;
    const vuelta = 2 * Math.PI * radio;
    const centro = tamano / 2;
    const sobrante = vuelta * (1 - porcentaje / 100);

    return `
        <svg class="anillo" viewBox="0 0 ${tamano} ${tamano}" xmlns="http://www.w3.org/2000/svg">
            <circle cx="${centro}" cy="${centro}" r="${radio}" fill="none" stroke="rgba(255,255,255,0.28)" stroke-width="${grosor}"></circle>
            <circle cx="${centro}" cy="${centro}" r="${radio}" fill="none" stroke="#ffffff" stroke-width="${grosor}"
                stroke-linecap="round" stroke-dasharray="${vuelta}" stroke-dashoffset="${vuelta}"
                transform="rotate(-90 ${centro} ${centro})">
                <animate attributeName="stroke-dashoffset" from="${vuelta}" to="${sobrante}" dur="1s" fill="freeze" calcMode="ease-out"></animate>
            </circle>
            <text x="50%" y="47%" text-anchor="middle" font-size="35">${porcentaje}%</text>
            <text x="50%" y="66%" text-anchor="middle" font-size="13" opacity="0.85">${etiqueta}</text>
        </svg>`;
}
