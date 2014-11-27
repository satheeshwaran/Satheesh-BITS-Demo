<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';
sec_session_start();
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Contextivity Home</title>
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
            </a>
          </div>
          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li><a class="nav-link" href="getting-started.html">Getting Started</a></li>
              <li><a class="nav-link" href="documentation.html">Documentation</a></li>
              <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><?php echo $_SESSION['username'];?><b class="caret"></b></a>
                          <ul class="dropdown-menu" role="menu">
                            <li><a href="myapps.php">My Applications</a></li>
                            <li><a href="#">Settings</a></li>
                            <li><a href="includes/logout.php">Logout</a></li>
                          </ul>
                        </li></ul>
          </div>
        </div>  
      </nav>
      <!--index-->
      <div class="index">
        <h2><div><p class="download-link" style="font-size: x-large;
">ContextKit is a next gen iBeacon suite that reduces cost,time and effort in setting up infrastrcuture for iBeacon-enabling one's apps, ContextKit comes with a Scalable Server Setup, Admin Console and a Mobile SDK</p></h2>
 <h3><div><p class="download-link"  >  Currently supports iOS & PhoneGap. More platforms coming soon!</p></h3>
<a href="home.php"><img src="img/slider6.png"></a>
        <p class="download-link">
          <a class="btn btn-primary" href="createNewApp.php">Create an App</a>
        </p>
      <!--footer-->
      <div class="site-footer">
        <div class="container">
          <div class="download">
            <span class="download__infos">You simply have to <b>try it</b>.</span>&nbsp;&nbsp;&nbsp;&nbsp;
            <a class="btn btn-primary" href="#">Download ContextKit</a>&nbsp;&nbsp;&nbsp;&nbsp;
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
