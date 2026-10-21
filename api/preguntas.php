<?php
// entrega las preguntas de un test (vocacional o admisión).
// Viven en la base de datos y no en el JS para que el navegador
// solo las reciba cuando alguien empieza el test.
// Cada test tiene sus tablas: vocacional_preguntas, admision_preguntas
// y admision_opciones.

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();

$testClave = $_GET['test'] ?? '';
$pdo = rem_obtener_bd();

$stmt = $pdo->prepare('SELECT id FROM tests WHERE clave = ? AND activo = 1');
$stmt->execute([$testClave]);
if (!$stmt->fetch()) {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.'], 404);
}

if ($testClave === 'vocacional') {
    // afirmaciones que se responden en una escala: solo llevan el texto
    $filas = $pdo->query('SELECT clave, area_clave, texto FROM vocacional_preguntas ORDER BY orden')->fetchAll();

    $resultado = array_map(function ($p) {
        return ['id' => $p['clave'], 'area' => $p['area_clave'], 'texto' => $p['texto']];
    }, $filas);
} elseif ($testClave === 'admision') {
    // preguntas de opción múltiple: llevan sus opciones y la respuesta correcta
    $filas = $pdo->query('SELECT id, clave, area_clave, texto, respuesta FROM admision_preguntas ORDER BY orden')->fetchAll();
    $stmtOpciones = $pdo->prepare('SELECT texto FROM admision_opciones WHERE pregunta_id = ? ORDER BY orden');

    $resultado = array_map(function ($p) use ($stmtOpciones) {
        $stmtOpciones->execute([$p['id']]);
        return [
            'id' => $p['clave'],
            'area' => $p['area_clave'],
            'texto' => $p['texto'],
            'opciones' => array_column($stmtOpciones->fetchAll(), 'texto'),
            'respuesta' => $p['respuesta'],
        ];
    }, $filas);
} else {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.'], 404);
}

rem_responder(['exito' => true, 'preguntas' => $resultado]);
