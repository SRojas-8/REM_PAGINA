<?php
/* =========================================================
   CONFIGURACION.PHP — Datos de conexión del backend
   ========================================================= */


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

define('CORREO_ADMIN', 'remuniversidades@gmail.com');

// URL pública del sitio, sin "/" al final.
define('URL_SITIO', 'http://localhost/REM_PAGINA');
