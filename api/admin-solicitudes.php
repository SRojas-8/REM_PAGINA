<?php
// panel de solicitudes Premium. Solo lo puede usar una cuenta con
// rol = 'admin' (se marca a mano desde phpMyAdmin)

require_once __DIR__ . '/sesion.php';
require_once __DIR__ . '/codigos.php';

rem_cabeceras_json();
$admin = rem_usuario_actual();
if (!$admin) {
    rem_responder(['exito' => false, 'mensaje' => 'Debes iniciar sesión.'], 401);
}
if ($admin['rol'] !== 'admin') {
    rem_responder(['exito' => false, 'mensaje' => 'No tienes permiso para esto.'], 403);
}

$pdo = rem_obtener_bd();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query(
        "SELECT s.id, s.referencia, s.valor, s.estado, s.fecha_solicitud,
                u.nombre, u.apellido, u.correo, u.telefono, t.nombre AS test_nombre
         FROM solicitudes_premium s
         JOIN usuarios u ON u.id = s.usuario_id
         JOIN tests t ON t.id = s.test_id
         ORDER BY s.fecha_solicitud DESC
         LIMIT 100"
    );
    rem_responder(['exito' => true, 'solicitudes' => $stmt->fetchAll()]);
}

$datos = rem_leer_json();
$solicitudId = (int) ($datos['id'] ?? 0);
$accion = $datos['accion'] ?? '';

$stmt = $pdo->prepare("SELECT * FROM solicitudes_premium WHERE id = ? AND estado = 'pendiente'");
$stmt->execute([$solicitudId]);
$solicitud = $stmt->fetch();
if (!$solicitud) {
    rem_responder(['exito' => false, 'mensaje' => 'Esa solicitud ya no está pendiente.']);
}

if ($accion === 'confirmar') {
    $pdo->prepare('UPDATE solicitudes_premium SET confirmada_por = ? WHERE id = ?')->execute([$admin['id'], $solicitudId]);
    $resultado = rem_generar_codigo_premium($solicitud);
    rem_responder(['exito' => true, 'mensaje' => "Código enviado a {$resultado['correo']}"]);
}

if ($accion === 'rechazar') {
    $pdo->prepare("UPDATE solicitudes_premium SET estado = 'rechazada', confirmada_por = ? WHERE id = ?")
        ->execute([$admin['id'], $solicitudId]);
    rem_responder(['exito' => true]);
}

rem_responder(['exito' => false, 'mensaje' => 'Acción inválida.']);
