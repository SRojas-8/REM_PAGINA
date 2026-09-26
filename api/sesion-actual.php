<?php
/* =========================================================
   SESION-ACTUAL.PHP — "¿Quién soy?"
   La consulta js/sesion.js en cada página para saber si hay
   sesión abierta y pintar el nav en consecuencia.
   ========================================================= */

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
$usuario = rem_usuario_actual();
rem_responder(['exito' => true, 'usuario' => $usuario]);
