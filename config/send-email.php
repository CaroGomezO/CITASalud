<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

// Rutas relativas para incluir los archivos de la librería
// ESTO GARANTIZA QUE EL ARCHIVO SE ENCUENTRE
$ruta_base = './../PHPMailer/'; 

require $ruta_base . 'Exception.php'; 
require $ruta_base . 'PHPMailer.php';
require $ruta_base . 'SMTP.php';

function send_appointment_email($paciente_correo, $paciente_nombre, $detalles_cita) {
    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->SMTPDebug = 0; 
        $mail->Debugoutput = 'html'; 
        $mail->Host       = 'smtp.gmail.com';      
        $mail->SMTPAuth   = true;
        $mail->Username   = 'epscitasalud@gmail.com'; 
        $mail->Password   = 'ntwdgesxlqsglpgz';         
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // 🔒 Cifrado TLS
        $mail->Port       = 587; 
        
        $mail->SMTPOptions = array(
            'ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => true
    )
);
// ...

        // Remitente y Destinatario
        $mail->setFrom('no-reply@CITASalud.com', 'Sistema Citas Medicas');
        $mail->addAddress($paciente_correo, $paciente_nombre);

        // Contenido del Correo (usa los detalles que obtuvimos de la BD)
        $mail->isHTML(true);
        $mail->Subject = 'Cita Confirmada: ' . $detalles_cita['fecha'];
        $mail->Body    = "
            <h1>¡Cita Agendada Exitosamente!</h1>
            <p>Hola <strong>{$paciente_nombre}</strong>,</p>
            <p>Detalles:</p>
            <ul>
                <li><strong>Profesional:</strong> {$detalles_cita['profesional']}</li>
                <li><strong>Especialidad:</strong> {$detalles_cita['especialidad']}</li>
                <li><strong>Fecha:</strong> {$detalles_cita['fecha']}</li>
                <li><strong>Hora:</strong> {$detalles_cita['hora']}</li>
                <li><strong>Sede:</strong> {$detalles_cita['sede']}</li>
            </ul>";
        $mail->AltBody = "Tu cita ha sido confirmada..."; 

        $mail->send();
        return true;
    } catch (Exception $e) {
        echo "<h1>FALLO CRÍTICO DE ENVÍO DE CORREO</h1>";
        echo "<p>La cita se agendó, pero el correo no pudo ser enviado.</p>";
        die("<strong>Error de Autenticación SMTP:</strong> " . $mail->ErrorInfo);  
    }
}
?>