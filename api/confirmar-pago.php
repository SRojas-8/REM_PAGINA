<?php
// confirma una solicitud desde el enlace del correo (id + token por GET)
// esta es una página normal para el navegador, no responde JSON

require_once __DIR__ . '/sesion.php';
require_once __DIR__ . '/codigos.php';

$pdo = rem_obtener_bd();

$solicitudId = (int) ($_GET['id'] ?? 0);
$token = (string) ($_GET['token'] ?? '');

$stmt = $pdo->prepare('SELECT * FROM solicitudes_premium WHERE id = ?');
$stmt->execute([$solicitudId]);
$solicitud = $stmt->fetch();

header('Content-Type: text/html; charset=utf-8');

if (!$solicitud || $solicitud['token_confirmacion'] !== $token) {
    echo '<h1>Enlace inválido</h1><p>Este enlace de confirmación no es válido.</p>';
    exit;
}
if ($solicitud['estado'] !== 'pendiente') {
    echo '<h1>Ya procesada</h1><p>Esta solicitud ya fue confirmada o rechazada antes.</p>';
    exit;
}

$resultado = rem_generar_codigo_premium($solicitud);
echo "<h1>Listo</h1><p>Se envió el código de acceso a {$resultado['correo']}.</p>";
