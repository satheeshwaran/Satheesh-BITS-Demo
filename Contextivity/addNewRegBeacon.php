<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';

sec_session_start(); 

$beacon_app_id = $_POST['existing_beacon_app_id'];
$beacon_name = $_POST['beaconNameField'];
$beacon_manufacturer = $_POST['beaconManufacturerField'];
$beacon_uuid = $_POST['beaconUUIDField'];
$beacon_location = $_POST['beaconLocationField'];
$beacon_major_value = $_POST['beaconMajorField'];
$beacon_minor_value = $_POST['beaconMinorField'];
$beacon_broadcast_message = $_POST['beaconBroadcastMsgField'];
$beacon_exit_message = $_POST['beaconExitMessageField'];
$beacon_broadcast_action = $_POST['beaconBroadcastActionField'];

if(isset($_POST['existing_beacon_id']))
{

	//update
/*
existing_beacon_app_id
beaconNameField
beaconManufacturerField
beaconUUIDField
beaconLocationField
beaconMajorField
beaconMinorField
beaconBroadcastMsgField
beaconExitMessageField
beaconBroadcastActionField*/

	if ($stmt = $mysqli->prepare("UPDATE registered_beacons SET beacon_name=?,beacon_manufacturer=?,beacon_location=?,beacon_major_value=?,beacon_minor_value=?,beacon_broadcast_message=?,beacon_exit_message=?,beacon_broadcast_action=? WHERE beacon_uuid = ?")) {

		$stmt->bind_param('sssssssss',$beacon_name,$beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action,$_POST['existing_beacon_id']);
		$stmt->execute(); 
		if ($mysqli->affected_rows>0) {
			//echo '<script language="javascript">alert("Beacon Update Success")</script>';   
			header("Location: myapps.php");
			exit;
		}
		else
		{
			//echo '<script language="javascript">alert("Sorry Beacon Update Failed, Please Try Again!")</script>';   
			header("Location: myapps.php");
		}
  	}

}

else
{
	$beacon_app_id = $_POST['existing_beacon_app_id'];
$beacon_name = $_POST['beaconNameField'];
$beacon_manufacturer = $_POST['beaconManufacturerField'];
$beacon_uuid = $_POST['beaconUUIDField'];
$beacon_location = $_POST['beaconLocationField'];
$beacon_major_value = $_POST['beaconMajorField'];
$beacon_minor_value = $_POST['beaconMinorField'];
$beacon_broadcast_message = $_POST['beaconBroadcastMsgField'];
$beacon_exit_message = $_POST['beaconExitMessageField'];
$beacon_broadcast_action = $_POST['beaconBroadcastActionField'];


	//insert
	if ($stmt = $mysqli->prepare("INSERT into registered_beacons (beacon_app_id,beacon_uuid,beacon_name,beacon_manufacturer,beacon_location,beacon_major_value,beacon_minor_value,beacon_broadcast_message,beacon_exit_message,beacon_broadcast_action) VALUES ('$beacon_app_id','$beacon_uuid','$beacon_name','$beacon_manufacturer','$beacon_location','$beacon_major_value','$beacon_minor_value','$beacon_broadcast_message','$beacon_exit_message','$beacon_broadcast_action')")) {
		$stmt->execute(); 
		if ($mysqli->affected_rows>0) {
			//echo '<script language="javascript">alert("Beacon Addition Success")</script>';   
			header("Location: myapps.php");
			exit;
		}
		else
		{
			//echo '<script language="javascript">alert("Sorry Beacon Addition Failed, Please Try Again!")</script>';   
			header("Location: myapps.php");
		}
  	}

}

?>