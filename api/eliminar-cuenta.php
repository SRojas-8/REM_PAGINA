<?php
// borra la cuenta del usuario, pidiendo la contraseña para confirmar
// (sus intentos de test quedan sin dueño, no se borran, para las
// estadísticas del sitio)

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
$clave = (string) ($datos['clave'] ?? '');

$pdo = rem_obtener_bd();
$stmt = $pdo->prepare('SELECT clave_hash FROM usuarios WHERE id = ?');
$stmt->execute([$usuario['id']]);
$fila = $stmt->fetch();

if (!password_verify($clave, $fila['clave_hash'])) {
    rem_responder(['exito' => false, 'mensaje' => 'Tu contraseña no es correcta.']);
}

$pdo->prepare('DELETE FROM usuarios WHERE id = ?')->execute([$usuario['id']]);

rem_iniciar_sesion_segura();
$_SESSION = [];
session_destroy();

rem_responder(['exito' => true]);
