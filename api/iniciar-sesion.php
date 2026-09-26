<?php
// login con correo y contraseña

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    rem_responder(['exito' => false, 'mensaje' => 'Método no permitido'], 405);
}

$datos  = rem_leer_json();
$correo = trim(strtolower($datos['correo'] ?? ''));
$clave  = (string) ($datos['clave'] ?? '');

$pdo = rem_obtener_bd();
$stmt = $pdo->prepare('SELECT id, nombre, apellido, correo, clave_hash, rol FROM usuarios WHERE correo = ?');
$stmt->execute([$correo]);
$usuario = $stmt->fetch();

// el mismo mensaje para correo inexistente y clave incorrecta, para no dar pistas
if (!$usuario || !password_verify($clave, $usuario['clave_hash'])) {
    rem_responder(['exito' => false, 'mensaje' => 'Correo o contraseña incorrectos.']);
}

rem_iniciar_sesion_segura();
$_SESSION['usuario_id'] = $usuario['id'];

$pdo->prepare('UPDATE usuarios SET ultimo_acceso = NOW() WHERE id = ?')->execute([$usuario['id']]);

rem_responder(['exito' => true, 'usuario' => [
    'id' => $usuario['id'], 'nombre' => $usuario['nombre'], 'apellido' => $usuario['apellido'],
    'correo' => $usuario['correo'], 'rol' => $usuario['rol'],
]]);
