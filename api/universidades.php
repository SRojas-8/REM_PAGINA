<?php
/* =========================================================
   UNIVERSIDADES.PHP — Lista de universidades para pregrados.html
   ========================================================= */

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
$pdo = rem_obtener_bd();
$stmt = $pdo->query('SELECT nombre, escudo, url_oferta FROM universidades WHERE activa = 1 ORDER BY orden');
rem_responder(['exito' => true, 'universidades' => $stmt->fetchAll()]);
