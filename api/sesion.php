<?php
// conexión a la BD, sesión y ayudas que usan los demás archivos de api/

require_once __DIR__ . '/configuracion.php';

function rem_obtener_bd(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
        $pdo = new PDO($dsn, DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]);
    }
    return $pdo;
}

function rem_iniciar_sesion_segura(): void {
    if (session_status() === PHP_SESSION_ACTIVE) return;
    session_set_cookie_params([
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

// se llama al principio de cada endpoint
function rem_cabeceras_json(): void {
    header('Content-Type: application/json; charset=utf-8');
}

function rem_responder(array $datos, int $codigo = 200): void {
    http_response_code($codigo);
    echo json_encode($datos);
    exit;
}

// Trae los datos del usuario que tiene la sesión abierta, o null si no hay sesión
function rem_usuario_actual(): ?array {
    rem_iniciar_sesion_segura();
    if (empty($_SESSION['usuario_id'])) return null;

    $pdo = rem_obtener_bd();
    $stmt = $pdo->prepare('SELECT id, nombre, apellido, correo, telefono, rol FROM usuarios WHERE id = ?');
    $stmt->execute([$_SESSION['usuario_id']]);
    $usuario = $stmt->fetch();
    return $usuario ?: null;
}

// Lee el cuerpo JSON de la petición
function rem_leer_json(): array {
    $datos = json_decode(file_get_contents('php://input'), true);
    return is_array($datos) ? $datos : [];
}
