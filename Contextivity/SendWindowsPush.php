<?php
//sending push notification using PHP

include_once 'windowsphonepush.php';

$uri=$_GET['device_uri']; //uri sended by Microsoft plateform
$notif=new WindowsPhonePushNotification($uri);
$notif->push_toast("this is a title","this is the sub title");

?>