<?php
// panel de administrador: crear, editar, ordenar, ocultar y eliminar
// las universidades de pregrados.html. Solo cuentas con rol 'admin';
// todo se valida aquí, en el servidor, no en el navegador.
//
// GET  -> lista completa (visibles y ocultas)
// POST -> multipart/form-data con el campo "accion"
//         (crear | editar | mover | visibilidad | eliminar)

require_once __DIR__ . '/sesion.php';

const CARPETA_ESCUDOS = __DIR__ . '/../img/imgpregrados/Unis/';
const TAMANO_MAX_ESCUDO = 1048576; // 1 MB
const TIPOS_ESCUDO = ['image/png' => 'png', 'image/jpeg' => 'jpg', 'image/webp' => 'webp'];

rem_cabeceras_json();
$admin = rem_usuario_actual();
if (!$admin) {
    rem_responder(['exito' => false, 'mensaje' => 'Debes iniciar sesión.'], 401);
}
if ($admin['rol'] !== 'admin') {
    rem_responder(['exito' => false, 'mensaje' => 'No tienes permiso para esto.'], 403);
}

$pdo = rem_obtener_bd();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query('SELECT id, nombre, escudo, url_oferta, orden, activa FROM universidades ORDER BY orden, id');
    rem_responder(['exito' => true, 'universidades' => $stmt->fetchAll()]);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    rem_responder(['exito' => false, 'mensaje' => 'Método no permitido'], 405);
}

function rem_error(string $mensaje): void {
    rem_responder(['exito' => false, 'mensaje' => $mensaje], 400);
}

// nombre y enlace de la oferta: el enlace solo puede ser http(s), para que
// nadie guarde un "javascript:" que se ejecutaría al hacer clic en Pregrados
function rem_datos_universidad(): array {
    $nombre = trim((string) ($_POST['nombre'] ?? ''));
    $url = trim((string) ($_POST['url_oferta'] ?? ''));

    if ($nombre === '' || mb_strlen($nombre) > 150) {
        rem_error('Escribe el nombre de la universidad (máximo 150 caracteres).');
    }
    $esquema = strtolower((string) parse_url($url, PHP_URL_SCHEME));
    if ($url === '' || strlen($url) > 500 || !filter_var($url, FILTER_VALIDATE_URL) || !in_array($esquema, ['http', 'https'], true)) {
        rem_error('El enlace de la oferta debe ser una dirección válida que empiece por http:// o https://');
    }
    return [$nombre, $url];
}

// valida la imagen subida y la guarda con un nombre generado aquí.
// Devuelve el nombre del archivo. El tipo se detecta por el contenido del
// archivo, nunca por su extensión ni por lo que declare el navegador.
function rem_guardar_escudo(array $archivo): string {
    if (($archivo['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_INI_SIZE || ($archivo['error'] ?? 0) === UPLOAD_ERR_FORM_SIZE) {
        rem_error('La imagen es demasiado grande (máximo 1 MB).');
    }
    if (($archivo['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK || !is_uploaded_file($archivo['tmp_name'])) {
        rem_error('No se pudo recibir la imagen. Intenta de nuevo.');
    }
    if ($archivo['size'] > TAMANO_MAX_ESCUDO) {
        rem_error('La imagen es demasiado grande (máximo 1 MB).');
    }

    $tipo = (new finfo(FILEINFO_MIME_TYPE))->file($archivo['tmp_name']);
    if (!isset(TIPOS_ESCUDO[$tipo]) || @getimagesize($archivo['tmp_name']) === false) {
        rem_error('El escudo debe ser una imagen PNG, JPG o WEBP.');
    }

    if (!is_dir(CARPETA_ESCUDOS) || !is_writable(CARPETA_ESCUDOS)) {
        rem_responder(['exito' => false, 'mensaje' => 'No se pudo guardar la imagen en el servidor.'], 500);
    }

    $nombre = 'escudo_' . bin2hex(random_bytes(8)) . '.' . TIPOS_ESCUDO[$tipo];
    if (!move_uploaded_file($archivo['tmp_name'], CARPETA_ESCUDOS . $nombre)) {
        rem_responder(['exito' => false, 'mensaje' => 'No se pudo guardar la imagen en el servidor.'], 500);
    }
    return $nombre;
}

// borra un escudo del disco, pero solo si lo subió este panel (nombre
// generado por nosotros) y ninguna otra universidad lo está usando.
// Los escudos originales del sitio nunca se borran.
function rem_borrar_escudo_si_sobra(PDO $pdo, string $archivo): void {
    if (!preg_match('/^escudo_[a-f0-9]{16}\.(png|jpg|webp)$/', $archivo)) return;

    $stmt = $pdo->prepare('SELECT COUNT(*) FROM universidades WHERE escudo = ?');
    $stmt->execute([$archivo]);
    if ((int) $stmt->fetchColumn() === 0 && is_file(CARPETA_ESCUDOS . $archivo)) {
        unlink(CARPETA_ESCUDOS . $archivo);
    }
}

function rem_buscar_universidad(PDO $pdo, int $id): array {
    $stmt = $pdo->prepare('SELECT * FROM universidades WHERE id = ?');
    $stmt->execute([$id]);
    $universidad = $stmt->fetch();
    if (!$universidad) {
        rem_responder(['exito' => false, 'mensaje' => 'Esa universidad ya no existe.'], 404);
    }
    return $universidad;
}

$accion = $_POST['accion'] ?? '';
$id = (int) ($_POST['id'] ?? 0);

try {
    if ($accion === 'crear') {
        [$nombre, $url] = rem_datos_universidad();
        $escudo = rem_guardar_escudo($_FILES['escudo'] ?? []);

        try {
            $orden = (int) $pdo->query('SELECT COALESCE(MAX(orden), 0) + 1 FROM universidades')->fetchColumn();
            $pdo->prepare('INSERT INTO universidades (nombre, escudo, url_oferta, orden, activa) VALUES (?, ?, ?, ?, 1)')
                ->execute([$nombre, $escudo, $url, $orden]);
        } catch (PDOException $e) {
            unlink(CARPETA_ESCUDOS . $escudo);
            throw $e;
        }
        rem_responder(['exito' => true, 'id' => (int) $pdo->lastInsertId()]);
    }

    if ($accion === 'editar') {
        $universidad = rem_buscar_universidad($pdo, $id);
        [$nombre, $url] = rem_datos_universidad();

        $escudo = $universidad['escudo'];
        $subioImagen = ($_FILES['escudo']['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
        if ($subioImagen) {
            $escudo = rem_guardar_escudo($_FILES['escudo']);
        }

        try {
            $pdo->prepare('UPDATE universidades SET nombre = ?, escudo = ?, url_oferta = ? WHERE id = ?')
                ->execute([$nombre, $escudo, $url, $id]);
        } catch (PDOException $e) {
            if ($subioImagen) unlink(CARPETA_ESCUDOS . $escudo);
            throw $e;
        }

        if ($subioImagen) {
            rem_borrar_escudo_si_sobra($pdo, $universidad['escudo']);
        }
        rem_responder(['exito' => true]);
    }

    if ($accion === 'mover') {
        $universidad = rem_buscar_universidad($pdo, $id);
        $arriba = ($_POST['direccion'] ?? '') === 'arriba';
        if (!$arriba && ($_POST['direccion'] ?? '') !== 'abajo') {
            rem_error('Dirección inválida.');
        }

        // el vecino es la universidad que está justo antes o justo después en la lista
        $stmt = $pdo->prepare($arriba
            ? 'SELECT id, orden FROM universidades WHERE (orden, id) < (?, ?) ORDER BY orden DESC, id DESC LIMIT 1'
            : 'SELECT id, orden FROM universidades WHERE (orden, id) > (?, ?) ORDER BY orden ASC, id ASC LIMIT 1');
        $stmt->execute([$universidad['orden'], $universidad['id']]);
        $vecino = $stmt->fetch();

        if ($vecino) {
            $pdo->beginTransaction();
            $cambiar = $pdo->prepare('UPDATE universidades SET orden = ? WHERE id = ?');
            // si por algún motivo tuvieran el mismo orden, se separan para que el cambio sí se note
            $ordenNuevo = (int) $vecino['orden'];
            $ordenVecino = (int) $universidad['orden'];
            if ($ordenNuevo === $ordenVecino) {
                $ordenNuevo += $arriba ? -1 : 1;
            }
            $cambiar->execute([$ordenNuevo, $universidad['id']]);
            $cambiar->execute([$ordenVecino, $vecino['id']]);
            $pdo->commit();
        }
        rem_responder(['exito' => true]);
    }

    if ($accion === 'visibilidad') {
        $universidad = rem_buscar_universidad($pdo, $id);
        $activa = $universidad['activa'] ? 0 : 1;
        $pdo->prepare('UPDATE universidades SET activa = ? WHERE id = ?')->execute([$activa, $id]);
        rem_responder(['exito' => true, 'activa' => $activa]);
    }

    if ($accion === 'eliminar') {
        $universidad = rem_buscar_universidad($pdo, $id);
        $pdo->prepare('DELETE FROM universidades WHERE id = ?')->execute([$id]);
        rem_borrar_escudo_si_sobra($pdo, $universidad['escudo']);
        rem_responder(['exito' => true]);
    }

    rem_error('Acción inválida.');
} catch (PDOException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    rem_responder(['exito' => false, 'mensaje' => 'No se pudo guardar el cambio.'], 500);
}
