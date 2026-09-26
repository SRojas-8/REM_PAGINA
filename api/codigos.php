<?php


require_once __DIR__ . '/sesion.php';
require_once __DIR__ . '/correo.php';

function rem_generar_codigo_premium(array $solicitud): array {
    $pdo = rem_obtener_bd();

    $stmt = $pdo->prepare('SELECT nombre, correo FROM usuarios WHERE id = ?');
    $stmt->execute([$solicitud['usuario_id']]);
    $usuario = $stmt->fetch();

    $stmt = $pdo->prepare('SELECT nombre FROM tests WHERE id = ?');
    $stmt->execute([$solicitud['test_id']]);
    $test = $stmt->fetch();

    
    $codigo = 'REM-' . strtoupper(bin2hex(random_bytes(2))) . '-' . strtoupper(bin2hex(random_bytes(2)));
    $hash = password_hash($codigo, PASSWORD_DEFAULT);

    $pdo->prepare(
        'INSERT INTO codigos_acceso (solicitud_id, usuario_id, test_id, codigo_hash, fecha_expiracion)
         VALUES (?, ?, ?, ?, DATE_ADD(NOW(), INTERVAL 30 MINUTE))'
    )->execute([$solicitud['id'], $solicitud['usuario_id'], $solicitud['test_id'], $hash]);

    $pdo->prepare("UPDATE solicitudes_premium SET estado = 'confirmada', fecha_confirmacion = NOW() WHERE id = ?")
        ->execute([$solicitud['id']]);

    $cuerpo = "<p>Hola {$usuario['nombre']},</p>
    <p>Confirmamos tu pago del <strong>{$test['nombre']} Premium</strong>. Este es tu código de acceso:</p>
    <p style=\"font-size:22px;font-weight:800;letter-spacing:2px;\">{$codigo}</p>
    <p>Es válido por 30 minutos y solo funciona en tu cuenta, para este test. Pégalo en la página donde hiciste la solicitud.</p>";

    rem_enviar_correo($usuario['correo'], "Tu código de acceso — {$test['nombre']}", $cuerpo, [
        'usuario_id' => $solicitud['usuario_id'], 'tipo' => 'codigo',
    ]);

    return ['correo' => $usuario['correo']];
}
