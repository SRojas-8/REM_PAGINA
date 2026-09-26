<?php
// pide acceso Premium a un test: crea una referencia de pago y le
// avisa a REM por correo con un enlace para confirmar cuando
// verifiquen el comprobante de Nequi que el estudiante manda por WhatsApp

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
$testClave = $datos['test'] ?? '';

$pdo = rem_obtener_bd();
$stmt = $pdo->prepare('SELECT id, nombre, precio_premium FROM tests WHERE clave = ? AND activo = 1');
$stmt->execute([$testClave]);
$test = $stmt->fetch();
if (!$test) {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.']);
}

// si ya tiene acceso, no hace falta pagar de nuevo
$stmt = $pdo->prepare('SELECT id FROM accesos_premium WHERE usuario_id = ? AND test_id = ?');
$stmt->execute([$usuario['id'], $test['id']]);
if ($stmt->fetch()) {
    rem_responder(['exito' => true, 'yaTieneAcceso' => true]);
}

$datosNequi = ['nequiNumero' => NEQUI_NUMERO, 'nequiTitular' => NEQUI_TITULAR];

// si ya hay una solicitud pendiente para este test, se reusa en vez de duplicar
$stmt = $pdo->prepare(
    "SELECT referencia FROM solicitudes_premium WHERE usuario_id = ? AND test_id = ? AND estado = 'pendiente' ORDER BY fecha_solicitud DESC LIMIT 1"
);
$stmt->execute([$usuario['id'], $test['id']]);
$pendiente = $stmt->fetch();

if ($pendiente) {
    rem_responder(['exito' => true, 'referencia' => $pendiente['referencia'], 'valor' => $test['precio_premium']] + $datosNequi);
}

$referencia = 'REM-' . str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);
$token = bin2hex(random_bytes(32));

$stmt = $pdo->prepare(
    'INSERT INTO solicitudes_premium (usuario_id, test_id, referencia, valor, token_confirmacion) VALUES (?, ?, ?, ?, ?)'
);
$stmt->execute([$usuario['id'], $test['id'], $referencia, $test['precio_premium'], $token]);
$solicitudId = (int) $pdo->lastInsertId();

$enlaceConfirmar = URL_SITIO . '/api/confirmar-pago.php?id=' . $solicitudId . '&token=' . $token;

$cuerpo = "<p>Nueva solicitud de Premium.</p>
<p><strong>Estudiante:</strong> {$usuario['nombre']} {$usuario['apellido']} ({$usuario['correo']})</p>
<p><strong>Test:</strong> {$test['nombre']}</p>
<p><strong>Referencia:</strong> {$referencia} — \${$test['precio_premium']}</p>
<p><a href=\"{$enlaceConfirmar}\">Confirmar este pago y enviar el código</a></p>
<p>Confírmalo solo después de verificar el comprobante de Nequi por WhatsApp.</p>";

rem_enviar_correo(CORREO_ADMIN, "Solicitud Premium — {$referencia}", $cuerpo, [
    'usuario_id' => $usuario['id'], 'tipo' => 'solicitud',
]);

rem_responder(['exito' => true, 'referencia' => $referencia, 'valor' => $test['precio_premium']] + $datosNequi);
