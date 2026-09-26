<?php
// valida el código que el estudiante escribe y activa el Premium
// el código solo sirve para el usuario y el test para el que se generó

require_once __DIR__ . '/sesion.php';

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
$codigo = trim((string) ($datos['codigo'] ?? ''));

$pdo = rem_obtener_bd();
$stmt = $pdo->prepare('SELECT id FROM tests WHERE clave = ?');
$stmt->execute([$testClave]);
$test = $stmt->fetch();
if (!$test) {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.']);
}

$stmt = $pdo->prepare(
    'SELECT * FROM codigos_acceso WHERE usuario_id = ? AND test_id = ? AND usado = 0 AND fecha_expiracion > NOW()'
);
$stmt->execute([$usuario['id'], $test['id']]);
$candidatos = $stmt->fetchAll();

$encontrado = null;
foreach ($candidatos as $c) {
    if (password_verify($codigo, $c['codigo_hash'])) {
        $encontrado = $c;
        break;
    }
}

if (!$encontrado) {
    rem_responder(['exito' => false, 'mensaje' => 'Código inválido, vencido o ya usado.']);
}

try {
    $pdo->prepare('UPDATE codigos_acceso SET usado = 1, fecha_uso = NOW() WHERE id = ?')->execute([$encontrado['id']]);
    $pdo->prepare(
        'INSERT INTO accesos_premium (usuario_id, test_id, codigo_id) VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE codigo_id = VALUES(codigo_id), fecha_activacion = NOW()'
    )->execute([$usuario['id'], $test['id'], $encontrado['id']]);
} catch (PDOException $e) {
    rem_responder(['exito' => false, 'mensaje' => 'No se pudo activar el Premium.'], 500);
}

rem_responder(['exito' => true]);
