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
    "SELECT i.id, t.clave AS test_clave, t.nombre AS test_nombre, i.modo, i.total_preguntas,
            i.correctas, i.porcentaje, i.puntaje_estimado, i.resumen, i.fecha
     FROM intentos i
     JOIN tests t ON t.id = i.test_id
     WHERE i.usuario_id = ?
     ORDER BY i.fecha DESC"
);
$stmt->execute([$usuario['id']]);
$intentos = $stmt->fetchAll();

$stmtAreas = $pdo->prepare(
    'SELECT area_clave, area_nombre, porcentaje, correctas, total FROM resultados_areas WHERE intento_id = ? ORDER BY porcentaje DESC'
);
foreach ($intentos as &$intento) {
    $stmtAreas->execute([$intento['id']]);
    $intento['areas'] = $stmtAreas->fetchAll();
}
unset($intento);

$stmt = $pdo->prepare(
    'SELECT t.clave AS test_clave FROM accesos_premium a JOIN tests t ON t.id = a.test_id WHERE a.usuario_id = ?'
);
$stmt->execute([$usuario['id']]);
$premium = array_column($stmt->fetchAll(), 'test_clave');

rem_responder(['exito' => true, 'usuario' => $usuario, 'premium' => $premium, 'intentos' => $intentos]);
