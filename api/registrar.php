<?php
// crea una cuenta nueva. La llama js/registro.js desde registro.html

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    rem_responder(['exito' => false, 'mensaje' => 'Método no permitido'], 405);
}

$datos = rem_leer_json();

$nombre   = trim($datos['nombre'] ?? '');
$apellido = trim($datos['apellido'] ?? '');
$correo   = trim(strtolower($datos['correo'] ?? ''));
$telefono = trim($datos['telefono'] ?? '');
$clave    = (string) ($datos['clave'] ?? '');

if (mb_strlen($nombre) < 2) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe tu nombre.']);
}
if (mb_strlen($apellido) < 2) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe tu apellido.']);
}
if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    rem_responder(['exito' => false, 'mensaje' => 'Correo electrónico inválido.']);
}
if (!preg_match('/^[0-9+()\s-]{7,20}$/', $telefono)) {
    rem_responder(['exito' => false, 'mensaje' => 'Escribe un número de teléfono válido.']);
}
if (strlen($clave) < 6) {
    rem_responder(['exito' => false, 'mensaje' => 'La contraseña debe tener mínimo 6 caracteres.']);
}

try {
    $pdo = rem_obtener_bd();

    $stmt = $pdo->prepare('SELECT id FROM usuarios WHERE correo = ?');
    $stmt->execute([$correo]);
    if ($stmt->fetch()) {
        rem_responder([
            'exito' => false,
            'correoExiste' => true,
            'mensaje' => 'Ya existe una cuenta registrada con ese correo.',
        ]);
    }

    $hash = password_hash($clave, PASSWORD_DEFAULT);

    $stmt = $pdo->prepare(
        'INSERT INTO usuarios (nombre, apellido, correo, telefono, clave_hash) VALUES (?, ?, ?, ?, ?)'
    );
    $stmt->execute([$nombre, $apellido, $correo, $telefono, $hash]);
    $usuarioId = (int) $pdo->lastInsertId();

    rem_iniciar_sesion_segura();
    $_SESSION['usuario_id'] = $usuarioId;

    rem_responder(['exito' => true, 'usuario' => [
        'id' => $usuarioId, 'nombre' => $nombre, 'apellido' => $apellido, 'correo' => $correo,
    ]]);
} catch (PDOException $e) {
    rem_responder(['exito' => false, 'mensaje' => 'Error del servidor. Intenta más tarde.'], 500);
}
