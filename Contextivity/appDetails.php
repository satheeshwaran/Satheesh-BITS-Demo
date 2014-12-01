<?php
include_once 'includes/db_connect.php';
require 'includes/functions.php';

sec_session_start(); 

$appID = strval($_POST["appID"]);

if ($stmt = $mysqli->prepare("SELECT app_id,created_by_user_id,app_name,app_description,app_api_key,created_at
  FROM applications
  WHERE app_id = ?")) {
$stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
$stmt->execute();    // Execute the prepared query.
$stmt->store_result();
// get variables from result.
$stmt->bind_result($app_id, $user_id, $app_name, $app_desc,$api_key,$created_at);
while ($stmt->fetch()) {

}
}

if(isset($user_id))
{
  if ($stmt = $mysqli->prepare("SELECT username FROM members WHERE id = ?")) 
  {
      $stmt->bind_param('s', $user_id);  // Bind "$email" to parameter.
      $stmt->execute();    // Execute the prepared query.
      $stmt->store_result();
      // get variables from result.
      $stmt->bind_result($app_user_name);
      while ($stmt->fetch()) {

      }
    }
  }
  ?>
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8">
    <title>Contextivity</title>
    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <!-- SmartAddon.com Verification -->
    <meta name="smartaddon-verification" content="936e8d43184bc47ef34e25e426c508fe" />
    <meta name="keywords" content="Contextivity is a Jambul component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
    <meta name="description" content="Contextivity is a Jambul component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
    <link rel="shortcut icon" href="favicon_16.ico"/>
    <link rel="bookmark" href="favicon_16.ico"/>
    <!-- site css -->
    <link rel="stylesheet" href="css/site.min.css">
    <link rel="stylesheet" href="css/customchanges.css">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,800,700,400italic,600italic,700italic,800italic,300italic" rel="stylesheet" type="text/css">
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="js/site.min.js"></script>
</head>
<body class="home">
  <div class="docs-header header--noBackground">
    <!--nav-->
    <nav class="navbar navbar-default" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="home.php" style="position: fixed;left: 0;padding-top: 5px;margin-left: 10px;padding-bottom: 5px;color: #fff;"><img src="img/header_logo_beacon.png" height="40" style="/* top: 5px; *//* left: 50px; *//* position: fixed; */padding-right: 10px;">Contextivity
          </a>        </div>
          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li><a class="nav-link" href="getting-started.html">Getting Started</a></li>
              <li><a class="nav-link" href="documentation.html">Documentation</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><?php echo $_SESSION['username'];?><b class="caret"></b></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#">My Applications</a></li>
                  <li><a href="#">Settings</a></li>
                  <li><a href="includes/logout.php">Logout</a></li>
                </ul>
              </li></ul>
            </div>
          </div>  
        </nav>
        <!--index-->
        <div class="index">
          <div class="panel appDetailsPanel" id="appDetailsPanel">
            <div class="panel-heading">
              <div class="apps-title"><strong><?php echo $app_name;?></strong></div>
              <button type="button" class="btn btn-success btn-block editApp" data-toggle="modal" data-target="#">
                <img class="" src="img/add.png" style="position: relative;left: 0px;float: left;top: 5px;">Edit App</button>
              </div>
            </div>
            <div class="panel">
              <div class="tabbable tabs-left clearfix">
                <ul id="myTab1" class="nav nav-tabs">
                  <li class="active"><a href="#appDetailsPanelContent" data-toggle="tab">App Details</a></li>
                  <li class=""><a href="#registeredBeaconsPanelContent" data-toggle="tab">Registered Beacons</a></li>
                  <li class=""><a href="#rogueBeaconsPanelContent" data-toggle="tab">Rogue Beacons</a></li>
                  <li class=""><a href="#appAnalyticsPanelContent" data-toggle="tab">App Analytics</a></li>
                  <li class=""><a href="#settingsPanelContent" data-toggle="tab">Settings</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                  <div class="tab-pane fade active in" id="appDetailsPanelContent">
                    <ul class="list-group" id="appBasicDetailsList">
                      <li class="list-group-item"><p>App Name: <?php echo $app_name;?></p></li>
                      <li class="list-group-item"><p>App Description: <?php echo $app_desc;?></p></li>
                      <li class="list-group-item"><p>App API Key: <?php echo $api_key;?></p></li>
                      <li class="list-group-item"><p>Created At: <?php echo $created_at;?></p></li>
                      <li class="list-group-item"><p>Created By: <?php echo $app_user_name;?></p></li>
                    </ul>
                  </div>
                  <div class="tab-pane fade" id="registeredBeaconsPanelContent">
                      <div class="row">
                        <?php
                        $appID = strval($_POST["appID"]);

                        if ($stmt = $mysqli->prepare("SELECT * FROM registered_beacons
                          WHERE beacon_app_id = ?")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_app_id, $beacon_uuid, $beacon_name, $beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action);
                        while ($stmt->fetch()) {
                             echo '<form class="appFragmentForm" id="'.$beacon_uuid.'" action="beaconDetails.php" method="POST">
                                   <div class="col-sm-6 col-md-3" style="width:20%">
                                   <div class="thumbnail">
                                   <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                   <div class="caption text-center">
                                   <h3>'.$beacon_name .'</h3>
                                   <p>UUID '.$beacon_uuid .'</p>
                                   <p>Minor '.$beacon_minor_value.'</p>
                                   <p>Major '.$beacon_major_value.'</p>
                                   <p><input type="hidden" name="beacon_uuid" value="'.$beacon_uuid.'"><button class="btn btn-danger" >UnRegister</button> <button class="btn btn-default beaconDetailsButton"  id="'.$beacon_uuid.'">Details</button></p>
                                   </div>
                                   </div>
                                   </div>
                                   </form>';
                        }
                        }
                          ?>
                          <form class="appFragmentForm" id="addNewRegBeaconButton" action="beaconDetails.php" method="POST">
                                   <?php echo '<input type="hidden" name="existing_beacon_app_id" value="'.$appID.'">';?>
                                   <div class="col-sm-6 col-md-3" style="width:20%">
                                   <div class="thumbnail">
                                   <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                   <div class="caption text-center">
                                   <h3><br/></h3>
                                   <p><br/></p>
                                   <p><br/></p>
                                   <p><br/></p>
                                   <p><input type="submit" class="btn btn-success beaconDetailsButton" id="addNewRegBeaconButton'" value="Add New Beacon"></input></p>
                                   </div>
                                   </div>
                                   </div>
                                   </form>
                      </div>
                     </div>
                  <div class="tab-pane fade" id="rogueBeaconsPanelContent">
                      <div class="row">
                         <?php
                        $appID = strval($_POST["appID"]);

                        if ($stmt = $mysqli->prepare("SELECT * FROM rogue_beacons
                          WHERE beacon_app_id = ?")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_app_id, $beacon_uuid, $beacon_name, $beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action);
                        while ($stmt->fetch()) {
                             echo '<form class="appFragmentForm" id="'.$beacon_uuid.'" action="rogueBeaconDetails.php" method="POST">
                                   <div class="col-sm-6 col-md-3" style="width:20%">
                                   <div class="thumbnail">
                                   <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                   <div class="caption text-center">
                                   <h3>'.$beacon_name .'</h3>
                                   <p>UUID '.$beacon_uuid .'</p>
                                   <p>Minor '.$beacon_minor_value.'</p>
                                   <p>Major '.$beacon_major_value.'</p>
                                   <p><input type="hidden" name="beacon_uuid" value="'.$beacon_uuid.'"><button class="btn btn-danger" >UnRegister</button> <button class="btn btn-default beaconDetailsButton"  id="'.$beacon_uuid.'">Details</button></p>
                                   </div>
                                   </div>
                                   </div>
                                   </form>';
                        }
                        }
                          ?>
                          <form class="appFragmentForm" id="addNewRogueBeaconButton" action="rogueBeaconDetails.php" method="POST">
                                   <?php echo '<input type="hidden" name="existing_beacon_app_id" value="'.$appID.'">';?>
                                   <div class="col-sm-6 col-md-3" style="width:20%">
                                   <div class="thumbnail">
                                   <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                   <div class="caption text-center">
                                   <h3><br/></h3>
                                   <p><br/></p>
                                   <p><br/></p>
                                   <p><br/></p>
                                   <p><input type="submit" class="btn btn-success beaconDetailsButton" id="addNewRogueBeaconButton'" value="Add New Beacon"></input></p>
                                   </div>
                                   </div>
                                   </div>
                                   </form>
                      </div>
                     </div>
                  <div class="tab-pane fade beaconAnalytics" id="appAnalyticsPanelContent">
            <div id="filterPanel">
              <p style="width: 10%; position: relative; float: left; top: 8px;"><strong style="float: left;">Filter Data By</strong></p>
            <div class="btn-group open">
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Beacon Name<span class="caret"></span></button>
              <ul class="dropdown-menu" id="beacon_name_list" role="menu">
                <li class="allRow"><a href="#">All</a></li>
                 <?php
                  if ($stmt = $mysqli->prepare("SELECT beacon_name,beacon_uuid FROM registered_beacons
                          WHERE beacon_app_id = ? GROUP BY(beacon_name)")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_name,$beacon_uuid);
                        while ($stmt->fetch()) 
                        {
                          echo '<li><a href="#" id='.$beacon_uuid.'>'.$beacon_name.'</a></li>';
                        }   
                        }
                  ?>
              </ul>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Beacon Location <span class="caret"></span></button>
              <ul class="dropdown-menu" role="menu" id="beacon_location_list">
                <li class="allRow"><a href="#">All</a></li>
                                <?php
                  if ($stmt = $mysqli->prepare("SELECT beacon_location FROM registered_beacons
                          WHERE beacon_app_id = ? GROUP BY(beacon_location)")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_name);
                        while ($stmt->fetch()) 
                        {
                          echo '<li><a href="#">'.$beacon_name.'</a></li>';
                        }   
                        }
                  ?>
              </ul>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Beacon Message <span class="caret"></span></button>
              <ul class="dropdown-menu" id="beacon_message_list" role="menu">
                <li class="allRow"><a href="#">All</a></li>
                   <?php
                  if ($stmt = $mysqli->prepare("SELECT beacon_broadcast_message FROM registered_beacons
                          WHERE beacon_app_id = ? GROUP BY(beacon_broadcast_message)")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_name);
                        while ($stmt->fetch()) 
                        {
                          echo '<li><a href="#">'.$beacon_name.'</a></li>';
                        }   
                        }
                  ?>
              </ul>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Users <span class="caret"></span></button>
              <ul class="dropdown-menu" id="user_name_list" role="menu">
                <li class="allRow"><a href="#">All</a></li>
                <?php
                  if ($stmt = $mysqli->prepare("SELECT user_name FROM beacon_analytics      
                       WHERE analytics_app_id = ? GROUP BY(user_name)")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($analytics_user_name);
                        while ($stmt->fetch()) 
                        {
                          echo '<li><a href="#">'.$analytics_user_name.'</a></li>';
                        }   
                        }
                  ?>
              </ul>
            </div>
            <div class="btn-group">
              <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Time Spent <span class="caret"></span></button>
              <ul class="dropdown-menu" id="beacon_session_duration" role="menu">
                <li class="allRow"><a href="#">All</a></li>
                <?php
                  if ($stmt = $mysqli->prepare("SELECT session_duration FROM beacon_analytics
                          WHERE analytics_app_id = ? GROUP BY(session_duration)")) {
                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($session_time);
                        while ($stmt->fetch()) 
                        {
                          echo '<li><a href="#">'.$session_time.'</a></li>';
                        }   
                        }
                  ?>
              </ul>
            </div>
            </div>
<br/><br/><br>         
<div id="analyticsDataDiv">
   <table class="table table-bordered table-striped responsive-utilities" style="width: auto;">
               <thead>
              <tr>
                <th>Beacon Name</th>
                <th>Manufacturer</th>
                <th>UUID</th>
                <th>Major</th>
                <th>Minor</th>
                <th>Location</th>
                <th>Broadcast Message</th>
                <th>User ID</th>
                <th>User Name</th>
                <th>Session Start Time</th>
                <th>Session End Time</th>
                <th>Time Spent Near Beacon</th>
              </tr>
            </thead>
            <tbody>
              <?php 

                        $appID = strval($_POST["appID"]);
                        if ($stmt = $mysqli->prepare("SELECT * FROM beacon_analytics
                          WHERE analytics_app_id = ?")) {

                        $stmt->bind_param('s', $appID);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($analytics_app_id,$analytics_beacon_uuid,$analytics_user_id,$analytics_user_name,$session_start,$session_end,$session_time,$created_at);
                        while ($stmt->fetch()) {

                              $beacon_data = getBeaconDetailsForBeaconID($analytics_beacon_uuid,$mysqli);
                              echo '<script language="javascript">console.log(123)</script>';   
                                echo ' <tr>
                                <td>'.$beacon_data["beacon_name"].'</td>
                                <td>'.$beacon_data["beacon_manufacturer"].'</td>
                                <td>'.$analytics_beacon_uuid.'</td>
                                <td>'.$beacon_data["beacon_major_value"].'</td>
                                <td>'.$beacon_data["beacon_minor_value"].'</td>
                                <td>'.$beacon_data["beacon_location"].'</td>
                                <td>'.$beacon_data["beacon_broadcast_message"].'</td>
                                <td>'.$analytics_user_id.'</td>
                                <td>'.$analytics_user_name.'</td>
                                <td>'.$session_start.'</td>
                                <td>'.$session_end.'</td>
                                <td>'.date('H:i', mktime(0,$session_time)).'</td>
                                </tr>';                       
                        }
                        }
              ?>
            </tbody>
          </table>
        </div>
                 </div>
                  <div class="tab-pane fade " id="settingsPanelContent">
                    <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone...</p>
                  </div>
                </div>
              </div>
            </div> 
          </div>
        </div>
      </div>
    </div>

  <div class="modal" id="beaconDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title" id="myModalLabel">Beacon Details</h4>
        </div>
        <div class="modal-body">
         <form id="createNewAppForm" method="post" action="addNewApp.php">
          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Name</label>
                    <input type="text" class="form-control" id="appNameField" name="appNameField" value="Pharmacy Floor1">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>       
          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Manufacturer</label>
                    <input type="text" class="form-control" id="appNameField" name="appNameField" value="Estimote">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>                       
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon UUID</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField" value="245gfdg5eyh5756757fdsf242">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Major Value</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField" value="25">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Minor Value</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField" value="234">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Message</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField" value="Welcome To Appollo Hospitals, Slide to check in">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Action</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField" value="NO_ACTION_DEFINED">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <input type="submit" class="btn btn-primary" id="saveButton"></input>
        </div>
        </form>
      </div>
    </div>
  </div>

    <!--footer-->
    <div class="site-footer">
      <div class="container">
        <div class="download">
          <span class="download__infos">You simply have to <b>try it</b>.</span>&nbsp;&nbsp;&nbsp;&nbsp;
          <a class="btn btn-primary" href="https://github.com/bootflat/bootflat.github.io/archive/master.zip">Download Contextivity</a>&nbsp;&nbsp;&nbsp;&nbsp;
          <a class="btn" href="documentation.html">Read the Documentation</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <hr class="dashed" />
        <div class="copyright Jambul">
          <p><b>Contextivity</b>&nbsp;&nbsp;&nbsp;&nbsp;</p>
          <p>&copy; 2014 <a href="http://www.flathemes.com" target="_blank">Satheeshwaran</a>, Inc. All rights reserved.</p>
        </div>
      </div>
    </div>

  </div>
<script>

$(".beaconDetailsButton").click(function (event) { 
        event.preventDefault();
        document.getElementById(this.id).submit();
  });

$("#addNewRegBeaconButton").click(function (event) { 
        event.preventDefault();
        document.getElementById(this.id).submit();
  });

$("#addNewRogueBeaconButton").click(function (event) { 
        event.preventDefault();
        document.getElementById(this.id).submit();
  });

$('#beacon_session_duration li a').on('click', function () {
    console.log("Selected Option:"+$(this).text());
});

$('#user_name_list li a').on('click', function () {
    console.log("Selected Option:"+$(this).text());
});

$('#beacon_message_list li a').on('click', function () {
    console.log("Selected Option:"+$(this).text());
});

$('#beacon_location_list li a').on('click', function () {
    console.log("Selected Option:"+$(this).text());
});

$('#beacon_name_list li a').on('click', function () {
    console.log("Selected Option:"+$(this).text());
    $.get("analyticsFetcher.php?q=WHERE beacon_uuid = '"+ this.id + "'",function(data,status){
    alert("Data: " + data + "\nStatus: " + status);
    });
});

</script>
</body>
</html>
