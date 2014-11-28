<?php
include_once 'GCMPushMessage.php';
$apiKey = "AIzaSyBGu3CphE-A7k0y6dUoP8WoLFHV-ETBJX8";
$devices = array('APA91bGCf1uzfuy4mv0KwKJzrU8LYIzGILajY0IkOQJ6_0r5EWgZWHYfrp23ql4nlmizfa8XJqHzkzW_pfZGQ3U8QSUnvPt_PEJYna3V70tE_2kEErddm6SQTB8rnDV-2mfz8u835NZ4riItGlBS0NT9TspuFm8W-Y51nefxPCP_nteXsfhkr9c');
$message = "The message to send";

$gcpm = new GCMPushMessage($apiKey);
$gcpm->setDevices($devices);
//$response = $gcpm->send($message, array('title' => 'Test title'));
echo $response;

send_notification($devices,$message);

function send_notification($registatoin_ids, $message) {
        // Set POST variables
        $url = 'https://android.googleapis.com/gcm/send';
 
        $fields = array(
            'registration_ids' => $registatoin_ids,
            'data' => $message,
        );
 
        $headers = array(
            'Authorization: key=AIzaSyBGu3CphE-A7k0y6dUoP8WoLFHV-ETBJX8',
            'Content-Type: application/json'
        );
        // Open connection
        $ch = curl_init();
 
        // Set the url, number of POST vars, POST data
        curl_setopt($ch, CURLOPT_URL, $url);
 
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
 
        // Disabling SSL Certificate support temporarly
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
 
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
 
        // Execute post
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }
 
        // Close connection
        curl_close($ch);
        echo $result;
    }
 ?>