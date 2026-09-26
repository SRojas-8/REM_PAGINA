<?php
// entrega las preguntas Premium, solo si el usuario tiene acceso
// pagado y activo para ese test (tabla accesos_premium)

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
$usuario = rem_usuario_actual();
if (!$usuario) {
    rem_responder(['exito' => false, 'mensaje' => 'Debes iniciar sesión.'], 401);
}

$testClave = $_GET['test'] ?? '';
$pdo = rem_obtener_bd();

$stmt = $pdo->prepare('SELECT id FROM tests WHERE clave = ?');
$stmt->execute([$testClave]);
$test = $stmt->fetch();
if (!$test) {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.']);
}

$stmt = $pdo->prepare('SELECT id FROM accesos_premium WHERE usuario_id = ? AND test_id = ?');
$stmt->execute([$usuario['id'], $test['id']]);
if (!$stmt->fetch()) {
    rem_responder(['exito' => false, 'mensaje' => 'No tienes Premium activo en este test.'], 403);
}

$stmt = $pdo->prepare('SELECT id, clave, area_clave, texto, tipo, respuesta FROM preguntas_premium WHERE test_id = ? ORDER BY orden');
$stmt->execute([$test['id']]);
$preguntas = $stmt->fetchAll();

$stmtOpciones = $pdo->prepare('SELECT texto FROM opciones_premium WHERE pregunta_id = ? ORDER BY orden');

$resultado = array_map(function ($p) use ($stmtOpciones) {
    $item = ['id' => $p['clave'], 'area' => $p['area_clave'], 'gratis' => false, 'texto' => $p['texto']];
    if ($p['tipo'] === 'opcion') {
        $stmtOpciones->execute([$p['id']]);
        $item['opciones'] = array_column($stmtOpciones->fetchAll(), 'texto');
        $item['respuesta'] = $p['respuesta'];
    }
    return $item;
}, $preguntas);

rem_responder(['exito' => true, 'preguntas' => $resultado]);
