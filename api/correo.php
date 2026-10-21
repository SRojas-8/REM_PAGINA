<?php
/* =========================================================
   CORREO.PHP — Envío de correos desde remuniversidades@gmail.com
   ========================================================= */

require_once __DIR__ . '/sesion.php';

function rem_enviar_correo(string $para, string $asunto, string $htmlBody, array $registro = []): bool {
    $phpmailerPath = __DIR__ . '/PHPMailer/src/PHPMailer.php';

    $exito = false;
    $error = null;

    if (!file_exists($phpmailerPath)) {
        $error = 'PHPMailer no está instalado. Revisa api/PHPMailer/LEEME.txt';
    } else {
        require_once $phpmailerPath;
        require_once __DIR__ . '/PHPMailer/src/SMTP.php';
        require_once __DIR__ . '/PHPMailer/src/Exception.php';

        try {
            $mail = new \PHPMailer\PHPMailer\PHPMailer(true);
            $mail->isSMTP();
            $mail->Host       = SMTP_HOST;
            $mail->SMTPAuth   = true;
            $mail->Username   = SMTP_USER;
            $mail->Password   = SMTP_PASS;
            $mail->SMTPSecure = \PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port       = SMTP_PORT;
            $mail->CharSet    = 'UTF-8';

            $mail->setFrom(SMTP_FROM_EMAIL, SMTP_FROM_NAME);
            $mail->addAddress($para);
            $mail->isHTML(true);
            $mail->Subject = $asunto;
            $mail->Body    = $htmlBody;

            $mail->send();
            $exito = true;
        } catch (\PHPMailer\PHPMailer\Exception $e) {
            $error = $mail->ErrorInfo;
        }
    }

    try {
        $pdo = rem_obtener_bd();
        $stmt = $pdo->prepare(
            'INSERT INTO informes_enviados (usuario_id, intento_id, tipo, correo_destino, enviado, error)
             VALUES (?, ?, ?, ?, ?, ?)'
        );
        $stmt->execute([
            $registro['usuario_id'] ?? null,
            $registro['intento_id'] ?? null,
            $registro['tipo'] ?? 'informe',
            $para,
            $exito ? 1 : 0,
            $error,
        ]);
    } catch (PDOException $e) {
    }

    return $exito;
}
