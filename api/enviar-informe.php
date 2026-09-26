<?php
// envía el informe de un test por correo. El HTML ya llega armado
// desde js/quiz-common.js y sale desde remuniversidades@gmail.com

require_once __DIR__ . '/sesion.php';
require_once __DIR__ . '/correo.php';

rem_cabeceras_json();
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    rem_responder(['exito' => false, 'mensaje' => 'Método no permitido'], 405);
}

$usuario = rem_usuario_actual();
if (!$usuario) {
    rem_responder(['exito' => false, 'mensaje' => 'Debes iniciar sesión.'], 401);
}
$datos = rem_leer_json();

$asunto = trim((string) ($datos['asunto'] ?? 'Tu informe — Red Educativa Medellín'));
$html = (string) ($datos['html'] ?? '');
$intentoId = isset($datos['intentoId']) ? (int) $datos['intentoId'] : null;

if ($html === '') {
    rem_responder(['exito' => false, 'mensaje' => 'El informe llegó vacío.']);
}

$enviado = rem_enviar_correo($usuario['correo'], $asunto, $html, [
    'usuario_id' => $usuario['id'], 'intento_id' => $intentoId, 'tipo' => 'informe',
]);

if (!$enviado) {
    rem_responder(['exito' => false, 'mensaje' => 'No se pudo enviar el correo. Intenta más tarde.'], 500);
}

rem_responder(['exito' => true]);
