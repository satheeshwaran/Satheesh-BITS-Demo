<?php

class RegBeacon implements JsonSerializable
{

public $channel_id;
public $channel_name;
public $channel_desc;
public $channel_app_id;
public $channel_auto_push_flag;

//new object constructor
function __construct($name,$desc,$app_id,$auto_flag)
{
$this->channel_name = $name;
$this->channel_desc = $desc;
$this->channel_app_id = $app_id;
$this->channel_auto_push_flag = $auto_flag;
$this->channel_id = md5(uniqid($name, true));
}

//existing object constructor
public static function channelWithDetails($name,$desc,$app_id,$auto_flag,$channel_id)
{
$this->channel_name = $name;
$this->channel_desc = $desc;
$this->channel_app_id = $app_id;
$this->channel_auto_push_flag = $auto_flag;
$this->channel_id = $channel_id;
}

public function jsonSerialize() {
return (object) get_object_vars($this);
}

public static function getAllChannelsForApiKey($api_key)
{

require '/../includes/db_connect.php';

$channels_array[] = array();

if ($stmt = $mysqli->prepare("SELECT * FROM push_message_channel where channel_app_id = ?"))
{
$stmt->bind_param('s', $api_key); // Bind "$email" to parameter.
$stmt->execute(); // Execute the prepared query.
$stmt->store_result();
// get variables from result.
$stmt->bind_result($chan_id,$chan_name,$chan_desc,$chan_job_flag,$chan_app_id);
while ($stmt->fetch())
{
$channelObject = new channel($chan_name,$chan_desc,$chan_app_id,$chan_job_flag,$chan_id);
$channels_array[] = $channelObject;
}
//print_r($channels_array);
return $channels_array;
}
}
}
?>