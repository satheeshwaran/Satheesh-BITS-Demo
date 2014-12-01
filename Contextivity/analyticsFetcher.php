<?php
include_once 'includes/db_connect.php';
require 'includes/functions.php';
$queryString = "SELECT * FROM beacon_analytics ".$_GET['q'];
$beacons_array = array();

if ($stmt = $mysqli->prepare($queryString)) {
	$stmt->execute();    
	$stmt->store_result();
	$stmt->bind_result($analytics_app_id,$analytics_beacon_uuid,$analytics_user_id,$analytics_user_name,$session_start,$session_end,$session_time,$created_at);
	while ($stmt->fetch()) {

	      $beacon_data = getBeaconDetailsForBeaconID($analytics_beacon_uuid,$mysqli);
          $analytics_data = array("beacon_name" => $beacon_data['beacon_name'],"beacon_manufacturer"=>$beacon_data['beacon_manufacturer'],"beacon_location"=>$beacon_data['beacon_location'],"beacon_major_value"=>$beacon_data['beacon_major_value'],"beacon_minor_value"=>$beacon_data['beacon_minor_value'],"beacon_broadcast_message"=>$beacon_data['beacon_broadcast_message'],"analytics_beacon_uuid"=>$analytics_beacon_uuid,"analytics_user_id" => $analytics_user_id,"analytics_user_name" => $analytics_user_name,"session_start" => $session_start,"session_end" => $session_end,"session_time" => $session_time);
	      array_push($beacons_array,$analytics_data);
	  }
    echo json_encode(array("results"=>$beacons_array));
}
else
{
	  echo trigger_error('Wrong SQL: ' . ' Error: ' . $mysqli->errno . ' ' . $mysqli->error, E_USER_ERROR);
}

?>