<?php
// edita nombre, apellido y teléfono. Si viene "claveNueva", primero
// valida "claveActual" antes de cambiarla

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

$nombre      = trim($datos['nombre'] ?? '');
$apellido    = trim($datos['apellido'] ?? '');
$telefono    = trim($datos['telefono'] ?? '');
$claveActual = (string) ($datos['claveActual'] ?? '');
$claveNueva  = (string) ($datos['claveNueva'] ?? '');

if (mb_strlen($nombre) < 2) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe tu nombre.']);
}
if (mb_strlen($apellido) < 2) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe tu apellido.']);
}
if (!preg_match('/^[0-9+()\s-]{7,20}$/', $telefono)) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe un número de teléfono válido.']);
}

$pdo = rem_obtener_bd();

// cambiar la contraseña es opcional, pero si se pide hay que confirmar la actual primero
$claveHashNueva = null;
if ($claveNueva !== '') {
    if (strlen($claveNueva) < 6) {
        rem_responder(['exito' => false, 'mensaje' => 'La nueva contraseña debe tener mínimo 6 caracteres.']);
    }
    $stmt = $pdo->prepare('SELECT clave_hash FROM usuarios WHERE id = ?');
    $stmt->execute([$usuario['id']]);
    $fila = $stmt->fetch();
    if (!password_verify($claveActual, $fila['clave_hash'])) {
        rem_responder(['exito' => false, 'mensaje' => 'Tu contraseña actual no es correcta.']);
    }
    $claveHashNueva = password_hash($claveNueva, PASSWORD_DEFAULT);
}

try {
    if ($claveHashNueva !== null) {
        $stmt = $pdo->prepare('UPDATE usuarios SET nombre = ?, apellido = ?, telefono = ?, clave_hash = ? WHERE id = ?');
        $stmt->execute([$nombre, $apellido, $telefono, $claveHashNueva, $usuario['id']]);
    } else {
        $stmt = $pdo->prepare('UPDATE usuarios SET nombre = ?, apellido = ?, telefono = ? WHERE id = ?');
        $stmt->execute([$nombre, $apellido, $telefono, $usuario['id']]);
    }
    rem_responder(['exito' => true, 'usuario' => ['nombre' => $nombre, 'apellido' => $apellido]]);
} catch (PDOException $e) {
    rem_responder(['exito' => false, 'mensaje' => 'No se pudo actualizar tu perfil.'], 500);
}
