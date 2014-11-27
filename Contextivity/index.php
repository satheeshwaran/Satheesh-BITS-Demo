<?php

define('STDIN',fopen("php://stdin","r"));

function checkForLogin()
{
  include_once 'includes/db_connect.php';
  include_once 'includes/functions.php';

  sec_session_start();

  if (login_check($mysqli) == true) {
    return true;

  } else {
    return false;
  }  
}

require 'Slim/Slim.php';
require 'Views/TwigView.php';


Slim::init(array('view' => 'TwigView'));  

Slim::get('/', function () {
  // Set data to be passed to the view template
  //ssSlim::view()->setData(array('title' => $title, 'body' => $body));
  
  // Tell Slim/Twig which template to render for this route

    if (checkForLogin() == true) {
    Slim::render('home.php');

    } else {
    Slim::render('login.php');

    }  
});

Slim::get('/home', function () {
  // Set data to be passed to the view template
  //ssSlim::view()->setData(array('title' => $title, 'body' => $body));
  
  // Tell Slim/Twig which template to render for this route

    if (checkForLogin() == true) {
    Slim::render('home.php');

    } else {
    //Slim::render('login.php');

    }  
});


// REST API METHODS // DONT DISTURB FOR UI CHANGES // WILL BE MOVED TO SOMEOTHER FILE //

function check_api_key($apiKey)
{

include_once 'includes/db_connect.php';
include_once 'includes/functions.php';

if ($stmt = $mysqli->prepare("SELECT app_api_key,app_id FROM applications
WHERE app_api_key = ?"))
{
$stmt->bind_param('s', $apiKey); // Bind "$email" to parameter.
$stmt->execute(); // Execute the prepared query.
$stmt->store_result();
// get variables from result.
$stmt->bind_result($api_key,$app_id);
while ($stmt->fetch())
{
}
if(isset($api_key))
return $app_id;
else
return "";
}
}

function get_api_key_from_header($header_data)
{
foreach ($header_data as $header => $value) {

if($header == 'api_key')
{
return $value;
}
}
}

Slim::get('/api/v1/registeredbeacons', function () {

$app = Slim::getInstance();

$api_key = get_api_key_from_header(apache_request_headers());

header('Content-Type: application/json');

$app_id = check_api_key($api_key);

if(strlen($app_id)>0)
{
  require 'includes/db_connect.php';


  if ($stmt = $mysqli->prepare("SELECT * FROM registered_beacons where beacon_app_id = ?"))
  {
    $beacons_array = array();
    $stmt->bind_param('s', $app_id); // Bind "$email" to parameter.
    $stmt->execute(); // Execute the prepared query.
    $stmt->store_result();
    // get variables from result.
    $stmt->bind_result($beacon_app_id, $beacon_uuid, $beacon_name, $beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action);
    while ($stmt->fetch())
    {
       array_push($beacons_array,array("beacon_app_id" => $beacon_app_id,"beacon_uuid" => $beacon_uuid,"beacon_name" => $beacon_name,"beacon_manufacturer" => $beacon_manufacturer,"beacon_location" => $beacon_location,"beacon_major_value" => $beacon_major_value,"beacon_minor_value" => $beacon_minor_value,"beacon_broadcast_message" => $beacon_broadcast_message));
    }
    header('Content-Type: application/json');

     echo json_encode(array("results"=>$beacons_array));
  }
}
else
  echo "{'message':'Invalid API Key'}";

});

Slim::get('/api/v1/roguebeacons', function () {

$app = Slim::getInstance();

$api_key = get_api_key_from_header(apache_request_headers());

header('Content-Type: application/json');

$app_id = check_api_key($api_key);

if(strlen($app_id)>0)
{
  require 'includes/db_connect.php';


  if ($stmt = $mysqli->prepare("SELECT * FROM rogue_beacons where beacon_app_id = ?"))
  {
    $beacons_array = array();
    $stmt->bind_param('s', $app_id); // Bind "$email" to parameter.
    $stmt->execute(); // Execute the prepared query.
    $stmt->store_result();
    // get variables from result.
    $stmt->bind_result($beacon_app_id, $beacon_uuid, $beacon_name, $beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action);
    while ($stmt->fetch())
    {
       array_push($beacons_array,array("beacon_app_id" => $beacon_app_id,"beacon_uuid" => $beacon_uuid,"beacon_name" => $beacon_name,"beacon_manufacturer" => $beacon_manufacturer,"beacon_location" => $beacon_location,"beacon_major_value" => $beacon_major_value,"beacon_minor_value" => $beacon_minor_value,"beacon_broadcast_message" => $beacon_broadcast_message));
    }
    header('Content-Type: application/json');

     echo json_encode(array("results"=>$beacons_array));
  }
}
else
  echo "{'message':'Invalid API Key'}";

});

/*
{"beacon_uuid:"B9407F30-F5F8-466E-AFF9-25556B57FE6D","user_id:"309222","user_name":"Satheesh","session_start_time":"11/11/2014 16:49:52","session_end_time":"11/11/2014 16:49:52","session_duration":"01:50"}
  */
Slim::post('/api/v1/beaconanalytics', function () {

$app = Slim::getInstance();

$api_key = get_api_key_from_header(apache_request_headers());

$app_id = check_api_key($api_key);

if(strlen($app_id)>0)
{
  require 'includes/db_connect.php';

  header('Content-Type: application/json');

  $data = json_decode(file_get_contents('php://input'), true);

    if(!$data == NULL)
    {
      //var_dump($data);
      if(!isset($data['beacon_uuid']) || !isset($data['user_id']) || !isset($data['user_name']) || !isset($data['session_start_time']) || !isset($data['session_end_time']) || !isset($data['session_duration']))
      {
          echo json_encode(array("status"=>"error","message_text"=>"Insufficient input parameters"),JSON_FORCE_OBJECT);  //parse and insert to beacon analytics\
          return;
      }

      else
      {
        echo'test';
        $beacon_uuid =$data['beacon_uuid'];
        $user_id = $data['user_id'];
        $user_name = $data['user_name'];
        $session_start_time = $data['session_start_time'];
        $session_end_time = $data['session_end_time'];
        $session_duration = $data['session_duration'];

            if ($stmt = $mysqli->prepare("INSERT into beacon_analytics (analytics_app_id,beacon_uuid,user_id,user_name,session_start_time,session_end_time,session_duration) VALUES ('$app_id','$beacon_uuid','$user_id','$user_name','$session_start_time','$session_end_time','$session_duration')")) 
            {
              $stmt->execute(); 
              if ($mysqli->affected_rows>0) 
                echo json_encode(array("status"=>"Success","message_text"=>"analytics data successfully submitted"),JSON_FORCE_OBJECT);  //parse and insert to beacon analytics
            }
      }
    }
    else
    {
        echo json_encode(array("status"=>"error","message_text"=>"Invalid input parameters2"),JSON_FORCE_OBJECT);  //parse and insert to beacon analytics
    }
}
else
  echo "{'message':'Invalid API Key'}";

});

/*
 * Run the Application
 */
Slim::run();

?>
