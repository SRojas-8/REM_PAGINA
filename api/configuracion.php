<?php
/* =========================================================
   CONFIGURACION.PHP — Datos de conexión del backend
   Edita SOLO los valores de la derecha cuando tengas tu hosting.
   Este archivo nunca se debe compartir públicamente (ni subirlo
   a un repositorio público) con las contraseñas reales puestas.
   ========================================================= */

// ---- Base de datos MySQL ----
// La mayoría de hostings compartidos (Hostinger, GoDaddy, etc.)
// te dan estos 4 datos al crear la base de datos desde el panel.
define('DB_HOST', 'localhost');
define('DB_NAME', 'rem_db');
define('DB_USER', 'root');
define('DB_PASS', '');

// ---- Correo (para enviar informes, códigos Premium y avisos) ----
// Datos del proveedor SMTP que estés usando (Brevo, Gmail, etc.)
// SMTP_USER y SMTP_PASS son para ENTRAR al proveedor de correo.
// SMTP_FROM_EMAIL es el correo que el estudiante VE como remitente
// (con Brevo casi nunca son el mismo dato; con Gmail sí lo eran).
define('SMTP_HOST', 'smtp-relay.sendinblue.com');
define('SMTP_PORT', 587);
define('SMTP_USER', 'b854be001@smtp-brevo.com');
define('SMTP_PASS', 'xsmtpsib-c3b069e565205374e63064ab6bf0110e39ce53229c0e2dc6ceb1e033a17b0566-UqZKdeGeLOqwsZ8N');
define('SMTP_FROM_EMAIL', 'remuniversidades@gmail.com');
define('SMTP_FROM_NAME', 'Red Educativa Medellín');

// Correo donde te llegan los avisos de nuevas solicitudes de pago
define('CORREO_ADMIN', 'remuniversidades@gmail.com');

// ---- Datos de pago que se le muestran al estudiante en premium.html ----
define('NEQUI_NUMERO', '324 509 4749');
define('NEQUI_TITULAR', 'Sara Rojas');

// URL pública del sitio, sin "/" al final. La usan los correos para
// armar el enlace de "Confirmar este pago".
define('URL_SITIO', 'http://localhost/REM_PAGINA');
