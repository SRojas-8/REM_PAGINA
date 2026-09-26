<?php
// guarda el resultado de un test al terminarlo, con o sin sesión
// abierta (si no hay sesión, usuario_id queda en NULL)

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    rem_responder(['exito' => false, 'mensaje' => 'Método no permitido'], 405);
}

$datos = rem_leer_json();
$usuario = rem_usuario_actual();

$testClave  = $datos['test'] ?? '';
$modo       = $datos['modo'] ?? 'gratis';
$areas      = $datos['areas'] ?? [];
$respuestas = $datos['respuestas'] ?? [];

if (!in_array($testClave, ['vocacional', 'admision'], true)) {
    rem_responder(['exito' => false, 'mensaje' => 'Test inválido.']);
}

$pdo = rem_obtener_bd();
$stmt = $pdo->prepare('SELECT id FROM tests WHERE clave = ?');
$stmt->execute([$testClave]);
$test = $stmt->fetch();
if (!$test) {
    rem_responder(['exito' => false, 'mensaje' => 'Test no encontrado.']);
}

try {
    $stmt = $pdo->prepare(
        'INSERT INTO intentos (usuario_id, test_id, modo, total_preguntas, correctas, porcentaje, puntaje_estimado, resumen, tiempo_segundos)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
    );
    $stmt->execute([
        $usuario['id'] ?? null,
        $test['id'],
        $modo === 'premium' ? 'premium' : 'gratis',
        (int) ($datos['totalPreguntas'] ?? 0),
        (int) ($datos['correctas'] ?? 0),
        (int) ($datos['porcentaje'] ?? 0),
        isset($datos['puntaje']) ? (int) $datos['puntaje'] : null,
        mb_substr((string) ($datos['resumen'] ?? ''), 0, 255),
        isset($datos['tiempoSegundos']) ? (int) $datos['tiempoSegundos'] : null,
    ]);
    $intentoId = (int) $pdo->lastInsertId();

    $stmtArea = $pdo->prepare(
        'INSERT INTO resultados_areas (intento_id, area_clave, area_nombre, porcentaje, correctas, total) VALUES (?, ?, ?, ?, ?, ?)'
    );
    foreach ($areas as $area) {
        $stmtArea->execute([
            $intentoId,
            (string) ($area['clave'] ?? ''),
            (string) ($area['nombre'] ?? ''),
            (int) ($area['porcentaje'] ?? 0),
            isset($area['correctas']) ? (int) $area['correctas'] : null,
            isset($area['total']) ? (int) $area['total'] : null,
        ]);
    }

    $stmtResp = $pdo->prepare(
        'INSERT INTO respuestas_intento (intento_id, pregunta_clave, area_clave, respuesta_dada, valor, correcta) VALUES (?, ?, ?, ?, ?, ?)'
    );
    foreach ($respuestas as $r) {
        $stmtResp->execute([
            $intentoId,
            (string) ($r['pregunta'] ?? ''),
            (string) ($r['area'] ?? ''),
            isset($r['respuesta']) ? (string) $r['respuesta'] : null,
            isset($r['valor']) ? (int) $r['valor'] : null,
            isset($r['correcta']) ? (int) (bool) $r['correcta'] : null,
        ]);
    }

    rem_responder(['exito' => true, 'intentoId' => $intentoId]);
} catch (PDOException $e) {
    rem_responder(['exito' => false, 'mensaje' => 'No se pudo guardar el intento.'], 500);
}
