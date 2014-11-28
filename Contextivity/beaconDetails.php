<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';
sec_session_start(); 

$beacon_uuid = "";
$beacon_existing_app_id="";

if(isset($_POST["beacon_uuid"]))
$beacon_uuid = strval($_POST["beacon_uuid"]);

if(isset($_POST["existing_beacon_app_id"]))
$beacon_existing_app_id = strval($_POST["existing_beacon_app_id"]);
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
  <meta name="keywords" content="PushKit is a Jambul component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
  <meta name="description" content="PushKit is a Jambul component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
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
            </a>              </div>
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
              <!-- Modal -->
    <div class="modal" id="beaconDetailsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title" id="myModalLabel">Registered Beacon Details</h4>
        </div>
        <div class="modal-body">
         <form id="createNewAppForm" method="post" action="addNewRegBeacon.php">
          <?php
            if(strlen($beacon_uuid)>0)
            {
              //edit funcationality
              echo '<input type="hidden" name="existing_beacon_id" value="'.$beacon_uuid.'">';
               if ($stmt = $mysqli->prepare("SELECT * FROM registered_beacons
                          WHERE beacon_uuid = ?")) {
                        $stmt->bind_param('s', $beacon_uuid);  // Bind "$email" to parameter.
                        $stmt->execute();    // Execute the prepared query.
                        $stmt->store_result();
                        // get variables from result.
                        $stmt->bind_result($beacon_app_id, $beacon_uuid, $beacon_name, $beacon_manufacturer,$beacon_location,$beacon_major_value,$beacon_minor_value,$beacon_broadcast_message,$beacon_exit_message,$beacon_broadcast_action);
                        while ($stmt->fetch()) {
                          echo '<input type="hidden" name="existing_beacon_app_id" value="'.$beacon_app_id.'">
                          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Name</label>
                    <input type="text" class="form-control" id="beaconNameField" name="beaconNameField" value="'.$beacon_name.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>       
          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Manufacturer</label>
                    <input type="text" class="form-control" id="beaconManufacturerField" name="beaconManufacturerField" value="'.$beacon_manufacturer.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>                       
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon UUID</label>
                    <input type="text" class="form-control" id="beaconUUIDField" name="beaconUUIDField" value="'.$beacon_uuid.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Location</label>
                    <input type="text" class="form-control" id="beaconLocationField" name="beaconLocationField" value="'.$beacon_location.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Major Value</label>
                    <input type="text" class="form-control" id="beaconMajorField" name="beaconMajorField" value="'.$beacon_major_value.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Minor Value</label>
                    <input type="text" class="form-control" id="beaconMinorField" name="beaconMinorField" value="'.$beacon_minor_value.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Message</label>
                    <input type="text" class="form-control" id="beaconBroadcastMsgField" name="beaconBroadcastMsgField" value="'.$beacon_broadcast_message.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Exit Message</label>
                    <input type="text" class="form-control" id="beaconExitMessageField" name="beaconExitMessageField" value="'.$beacon_exit_message.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
                    <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Action</label>
                    <input type="text" class="form-control" id="beaconBroadcastActionField" name="beaconBroadcastActionField" value="'.$beacon_broadcast_action.'">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>';

                        }
            }
          }
            else
            {
              //add functionality
              echo '<input type="hidden" name="existing_beacon_app_id" value="'.$beacon_existing_app_id.'">
                          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Name</label>
                    <input type="text" class="form-control" id="beaconNameField" name="beaconNameField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>       
          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">Beacon Manufacturer</label>
                    <input type="text" class="form-control" id="beaconManufacturerField" name="beaconManufacturerField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>                       
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon UUID</label>
                    <input type="text" class="form-control" id="beaconUUIDField" name="beaconUUIDField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Location</label>
                    <input type="text" class="form-control" id="beaconLocationField" name="beaconLocationField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Major Value</label>
                    <input type="text" class="form-control" id="beaconMajorField" name="beaconMajorField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Minor Value</label>
                    <input type="text" class="form-control" id="beaconMinorField" name="beaconMinorField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Message</label>
                    <input type="text" class="form-control" id="beaconBroadcastMsgField" name="beaconBroadcastMsgField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Exit Message</label>
                    <input type="text" class="form-control" id="beaconExitMessageField" name="beaconExitMessageField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
                    <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">Beacon Broadcast Action</label>
                    <input type="text" class="form-control" id="beaconBroadcastActionField" name="beaconBroadcastActionField" value="">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>';
            }
          ?>
         
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <input type="submit" class="btn btn-primary" id="saveButton"></input>
        </div>
        </form>
      </div>
    </div>
  </div>
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
      $(".appDetailsButton").click(function (event) { 
        event.preventDefault();
        console.log(this.id);
        document.getElementById(this.id).submit();
      });

      $(window).load(function(){
        $('#beaconDetailsModal').modal('show');
      });

      $('#beaconDetailsModal').on('hidden.bs.modal', function (e) {
        window.location = "myapps.php";
      });

      function empty() {
        var x;
        x = document.getElementById("appNameField").value;
        if (x == "") {
          alert("Enter a Valid App Name");
          return false;
        };
}
</script>
</body>
</html>