<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';
require 'includes/utils.php';

use Utils\RandomStringGenerator;

sec_session_start(); 

$appname = $_POST['appNameField'];
$app_description = $_POST['appDescriptionField'];
$created_by_user_id = $_SESSION['user_id'];
$generator = new RandomStringGenerator($appname);
$tokenLength = 32;
$generated_api_key = $generator->getToken(32);
$generated_app_id = md5(uniqid($appname, true));
$now = new DateTime();
$created_at = $now;

	if ($stmt = $mysqli->prepare("INSERT into applications (app_name,app_description,created_by_user_id,created_at,app_id,app_api_key) VALUES ('$appname','$app_description','$created_by_user_id',now(),'$generated_app_id','$generated_api_key')")) {
		$stmt->execute(); 
		if ($mysqli->affected_rows>0) {
					//echo '<script language="javascript">alert("success")</script>';   
			header("Location: myapps.php");
			exit;
		}
		else
		{
			echo '<script language="javascript">alert("Sorry App Creation Failed, Please Try Again!")</script>';   
			header("Location: myapps.php");
		}
  	}
?>