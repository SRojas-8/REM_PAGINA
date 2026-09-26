<?php
/* =========================================================
   CERRAR-SESION.PHP — Cierra la sesión del usuario
   ========================================================= */

require_once __DIR__ . '/sesion.php';

rem_cabeceras_json();
rem_iniciar_sesion_segura();
$_SESSION = [];
session_destroy();
rem_responder(['exito' => true]);
