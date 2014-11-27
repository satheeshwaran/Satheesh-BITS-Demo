<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';
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
    <title>PushKit</title>
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
              <div class="apps-title"><?php echo $app_name;?></div>
              <button type="button" class="btn btn-success btn-block editApp" data-toggle="modal" data-target="#beaconDetailsModal">
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
                              <div class="col-sm-6 col-md-3" style="width:20%">
                                <div class="thumbnail">
                                  <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                 <div class="caption text-center">
                                  <h3>Pharmacy Floor1</h3>
                                  <p>UUID 47895793402ffety3058034tgeg</p>
                                  <p>Minor 25</p>
                                  <p>Major 234</p>
                                  <p><input type="hidden" name="appID" value="232443b7"><button class="btn btn-danger" >UnRegister</button> <button class="btn btn-default beaconDetailsButton"  id="232443b7">Details</button></p>
                                 </div>
                              </div>
                              </div>
                              <div class="col-sm-6 col-md-3" style="width:20%">
                                <div class="thumbnail">
                                  <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                 <div class="caption text-center">
                                  <h3>Guest Room Floor1</h3>
                                  <p>UUID 245gfdg5eyh5756757fdsf242</p>
                                  <p>Minor 25</p>
                                  <p>Major 234</p>
                                  <p><input type="hidden" name="appID" value="232443b7"><button class="btn btn-danger" >UnRegister</button> <button class="btn btn-default beaconDetailsButton" id="232443b7">Details</button></p>
                                 </div>
                              </div>
                              </div>
                       </div>
                     </div>
                  <div class="tab-pane fade" id="rogueBeaconsPanelContent">
                     <div class="row">
                              <div class="col-sm-6 col-md-3" style="width:20%">
                                <div class="thumbnail">
                                  <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                 <div class="caption text-center">
                                  <h3>Rogue Beacon-Tony Stark</h3>
                                  <p>UUID 47895793402ffety3058034tgeg</p>
                                  <p>Minor 25</p>
                                  <p>Major 234</p>
                                  <p><input type="hidden" name="appID" value="232443b7"><button class="btn btn-danger" data-toggle="modal" data-target="#beaconDetailsModal">UnRegister</button> <button class="btn btn-default appDetailsButton" id="232443b7">Details</button></p>
                                 </div>
                              </div>
                              </div>
                           </form>
                            <form class="appFragmentForm" id="232443b7" action="appDetails.php" method="POST">
                              <div class="col-sm-6 col-md-3" style="width:20%">
                                <div class="thumbnail">
                                  <img class="img-rounded appIcon" src="img/beacon-details-logo.png">
                                 <div class="caption text-center">
                                  <h3>Rogue Beacon-Pepper Potts</h3>
                                  <p>UUID 245gfdg5eyh5756757fdsf242</p>
                                  <p>Minor 25</p>
                                  <p>Major 234</p>
                                  <p><input type="hidden" name="appID" value="232443b7"><button class="btn btn-danger" data-toggle="modal" data-target="#beaconDetailsModal">UnRegister</button> <button class="btn btn-default appDetailsButton" id="232443b7">Details</button></p>
                                 </div>
                              </div>
                              </div>
                       </div>                  
                     </div>
                  <div class="tab-pane fade beaconAnalytics" id="appAnalyticsPanelContent">
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
              <tr>
                <td>Pharmacy Floor1</td>
                <td>Estimote</td>
                <td>47895793402ffety3058034tgeg</td>
                <td>25</td>
                <td>234</td>
                <td>Pharmacy 1st Floor</td>
                <td>Welcome To Appollo Hospitals, Slide to check in</td>
                <td>309222</td>
                <td>Satheeshwaran</td>
                <td>11/11/2014 16:48:32</td>
                <td>11/11/2014 16:49:52</td>
                <td>01:50</td>
              </tr>
              <tr>
                <td>Pharmacy Floor1</td>
                <td>Estimote</td>
                <td>47895793402ffety3058034tgeg</td>
                <td>25</td>
                <td>234</td>
                <td>Pharmacy 1st Floor</td>
                <td>Welcome To Appollo Hospitals, Slide to check in</td>
                <td>309222</td>
                <td>Satheeshwaran</td>
                <td>11/11/2014 16:48:32</td>
                <td>11/11/2014 16:49:52</td>
                <td>01:50</td>

              </tr>
              <tr>
                <td>Pharmacy Floor1</td>
                <td>Estimote</td>
                <td>47895793402ffety3058034tgeg</td>
                <td>25</td>
                <td>234</td>
                <td>Pharmacy 1st Floor</td>
                <td>Welcome To Appollo Hospitals, Slide to check in</td>
                <td>309222</td>
                <td>Satheeshwaran</td>
                <td>11/11/2014 16:48:32</td>
                <td>11/11/2014 16:49:52</td>
                <td>01:50</td>

              </tr>
              <tr>
                <td>Pharmacy Floor1</td>
                <td>Estimote</td>
                <td>47895793402ffety3058034tgeg</td>
                <td>25</td>
                <td>234</td>
                <td>Pharmacy 1st Floor</td>
                <td>Welcome To Appollo Hospitals, Slide to check in</td>
                <td>309222</td>
                <td>Satheeshwaran</td>
                <td>11/11/2014 16:48:32</td>
                <td>11/11/2014 16:49:52</td>
                <td>01:50</td>
              </tr>
            </tbody>
          </table>
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
          <a class="btn btn-primary" href="https://github.com/bootflat/bootflat.github.io/archive/master.zip">Download PushKit</a>&nbsp;&nbsp;&nbsp;&nbsp;
          <a class="btn" href="documentation.html">Read the Documentation</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <hr class="dashed" />
        <div class="copyright Jambul">
          <p><b>PushKit</b>&nbsp;&nbsp;&nbsp;&nbsp;</p>
          <p>&copy; 2014 <a href="http://www.flathemes.com" target="_blank">Jambul</a>, Inc. All rights reserved.</p>
        </div>
      </div>
    </div>

  </div>
<script>

$( ".beaconDetailsButton" ).click(function() {
     $('#beaconDetailsModal').modal('show');
});


</script>
</body>
</html>
