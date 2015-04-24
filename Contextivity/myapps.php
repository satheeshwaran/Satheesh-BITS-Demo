<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';
sec_session_start(); 
?>
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8">
      <title>Contextivity Apps</title>
      <!-- Sets initial viewport load and disables zooming  -->
      <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
      <!-- SmartAddon.com Verification -->
      <meta name="smartaddon-verification" content="936e8d43184bc47ef34e25e426c508fe" />
  	<meta name="keywords" content="PushKit is a Satheeshwaran component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
  	<meta name="description" content="PushKit is a Satheeshwaran component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
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
              <a class="navbar-brand" href="home.php" style="position: fixed;left: 0;padding-top: 5px;margin-left: 10px;padding-bottom: 5px;color: #fff;"><img src="img/header_logo_beacon.png" height="40" style="/* top: 5px; *//* left: 50px; *//* position: fixed; */padding-right: 10px;">Contextivity</a>
            </div>
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
   <div class="example" id="appsGridView">
  <div class="panel panel-default">
                <div class="panel-heading">
                  <div class="apps-title">My Contextivity Apps</div>
                  <button type="button" class="btn btn-success btn-block createNewApp" onclick="location.href = 'createNewApp.php';">
                                  <img class="" src="img/add.png" style="position: relative;left: 0px;float: left;top: 5px;">Create New App</button>
                </div>
                <div class="panel-body">
   <div class="row" >
              <?php
  if ($stmt = $mysqli->prepare("SELECT app_id,created_by_user_id,app_name,app_description,app_api_key 
  FROM applications
  WHERE created_by_user_id = ? ORDER BY created_at DESC")) {
          $stmt->bind_param('s', $_SESSION['user_id']);  // Bind "$email" to parameter.
          $stmt->execute();    // Execute the prepared query.
          $stmt->store_result();
          // get variables from result.
          $stmt->bind_result($app_id, $user_id, $app_name, $app_desc,$api_key);
                while ($stmt->fetch()) {
                    echo '<form class="appFragmentForm" id="'.$app_id.'" action="appDetails.php" method="POST">
                    <div class="col-sm-6 col-md-3"><div class="thumbnail">
                               <img class="img-rounded appIcon" src="img/icon_app_placeholder.png">
                  <div class="caption text-center">
                    <h3>'.$app_name.'</h3>
                    <p>'.$app_desc.'</p>
                    <p><input type="hidden" name="appID" value="'.$app_id.'"><button class="btn btn-danger" data-toggle="modal" data-target="deleteAppModal">Delete App</button> <button class="btn btn-default appDetailsButton" id="'.$app_id.'">View Details</button></p>
                  </div>
                </div>
              </div>
              </form>'; 
                 }
               }
  ?>
            </div>
            <!-- Modal -->
  <div class="modal fade" id="createNewAppModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title" id="myModalLabel">New PushKit App</h4>
        </div>
        <div class="modal-body">
         <form id="createNewAppForm" method="post" action="addNewApp.php">
          <div class="form-group has-success has-feedback">
                    <label for="inputSuccess2">App Name</label>
                    <input type="text" class="form-control" id="appNameField" name="appNameField">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
          <div class="form-group has-success has-feedback">
                    <label  for="inputSuccess2">App Description</label>
                    <input type="text" class="form-control" id="appDescriptionField" name="appDescriptionField">
                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <input type="submit" class="btn btn-primary" id="saveButton"></input>
        </div>
        </form>
      </div>
    </div>
  </div>

  <div class="modal fade" id="deleteAppModal">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Contact</h4>
                  </div>
                  <div class="modal-body">
                    <p>Feel free to contact us for any issues you might have with our products.</p>
                    <div class="row">
                      <div class="col-xs-6">
                        <label>Name</label>
                        <input type="text" class="form-control" placeholder="Name">
                      </div>
                      <div class="col-xs-6">
                        <label>Email</label>
                        <input type="text" class="form-control" placeholder="Email">
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-xs-12">
                        <label>Message</label>
                        <textarea class="form-control" rows="3">Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac</textarea>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success">Send</button>
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
            <div class="copyright Satheeshwaran">
            <p><b>Contextivity</b>&nbsp;&nbsp;&nbsp;&nbsp;</p>
              <p>&copy; 2014 <a href="http://www.flathemes.com" target="_blank">Satheeshwaran</a>, Inc. All rights reserved.</p>
            </div>
          </div>
        </div>

      </div>
      <script>$(".appDetailsButton").click(function (event) { 
        event.preventDefault();
        console.log(this.id);
        document.getElementById(this.id).submit();
  });</script>

      <!--<script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-48721682-1', 'bootflat.github.io');
  	  ga('require', 'displayfeatures');
        ga('send', 'pageview');

      </script>-->
    </body>
  </html>