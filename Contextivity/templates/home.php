<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';

class CustomView extends \Slim\View
{
  public function render($template, $data = NULL)
  {
    return '<!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8">
    <title>Contextivity Login</title>
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
    <a class="navbar-brand" href="home.php"><img src="img/ibeacon-logo.png" height="40" style="top: 5px;left: 20px;position: fixed;"></a>
    </div>
    <div class="collapse navbar-collapse">
    <ul class="nav navbar-nav navbar-right">
    <li><a class="nav-link" href="getting-started.html">Getting Started</a></li>
    <li><a class="nav-link" href="documentation.html">Documentation</a></li>
    <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><?php echo $_SESSION["username"];?><b class="caret"></b></a>
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
    ">PushKit is a Satheeshwaran component that reduces cost,time and effort in setting up infrastrcuture for Push-enabling their apps, PushKit comes with a Scalable Server Setup, Admin Console and a Mobile SDK</p></h2>
    <h3><div><p class="download-link"  >  Currently supports iOS and Android. More platforms coming soon!</p></h3>
    <a href="home.php"><img src="img/slide1_illustration.png"></a>
    <p class="download-link">
    <a class="btn btn-primary" href="https://github.com/Bootflat/Bootflat.github.io/archive/master.zip">Create an App</a>
    </p>
    <!--footer-->
    <div class="site-footer">
    <div class="container">
    <div class="download">
    <span class="download__infos">You simply have to <b>try it</b>.</span>&nbsp;&nbsp;&nbsp;&nbsp;
    <a class="btn btn-primary" href="https://github.com/bootflat/bootflat.github.io/archive/master.zip">Download PushKit</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a class="btn" href="documentation.html">Read the Documentation</a>&nbsp;&nbsp;&nbsp;&nbsp;
    </div>
    <hr class="dashed" />
    <div class="copyright Satheeshwaran">
    <p><b>PushKit</b>&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p>&copy; 2014 <a href="http://www.flathemes.com" target="_blank">Satheeshwaran</a>, Inc. All rights reserved.</p>
    </div>
    </div>
    </div>

    </div>
    </body>
    </html>';
  }
}
?>