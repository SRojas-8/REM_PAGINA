<?php
// datos del usuario y su historial de tests

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
$usuario = rem_usuario_actual();
if (!$usuario) {
    rem_responder(['exito' => false, 'mensaje' => 'Debes iniciar sesión.'], 401);
}
$pdo = rem_obtener_bd();

$stmt = $pdo->prepare(
    "SELECT i.id, t.nombre AS test_nombre, i.resumen, i.fecha
     FROM intentos i
     JOIN tests t ON t.id = i.test_id
     WHERE i.usuario_id = ?
     ORDER BY i.fecha DESC"
);
$stmt->execute([$usuario['id']]);
$intentos = $stmt->fetchAll();

$stmtAreas = $pdo->prepare(
    'SELECT area_nombre, porcentaje FROM resultados_areas WHERE intento_id = ? ORDER BY porcentaje DESC'
);
foreach ($intentos as &$intento) {
    $stmtAreas->execute([$intento['id']]);
    $intento['areas'] = $stmtAreas->fetchAll();
}
unset($intento);

rem_responder(['exito' => true, 'usuario' => $usuario, 'intentos' => $intentos]);
