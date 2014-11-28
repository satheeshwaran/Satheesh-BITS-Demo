<?php
include_once 'includes/db_connect.php';
include_once 'includes/functions.php';

class CustomView extends \Slim\View
{
  public function render($template, $data = NULL)
  {
    if (login_check($mysqli) == true) {
      $logged = 'in';
    } else {
      $logged = 'out';
    }

     '<html>
    <head>
    <!-- Sets initial viewport load and disables zooming  -->
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <!-- SmartAddon.com Verification -->
    <meta name="smartaddon-verification" content="936e8d43184bc47ef34e25e426c508fe" />
    <meta name="keywords" content="Contextivity is a component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
    <meta name="description" content="Contextivity is a component that aims at enabling apps with remote notification capability very easily. Scalable server component, Admin Console and a mobile SDK">
    <link rel="shortcut icon" href="favicon_16.ico"/>
    <link rel="bookmark" href="favicon_16.ico"/>
    <meta charset="UTF-8">
    <script type="text/JavaScript" src="js/sha512.js"></script> 
    <script type="text/JavaScript" src="js/forms.js"></script> 
    <title>Contextivity</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
    </head>
    <body>
    <section>
    <div id="headerLogo">  <img src="img/ibeacon-logo.png" height="40"  >
    </div>
    <h1>Welcome To Contextivity, Please LogIn</h1> 
    <form action="includes/process_login.php" method="post" name="login_form">                      
    <input placeholder="User Name" name="email" type="text">
    <input placeholder="Password" type="password" id="password">
    <input name="submit" type="submit" id="loginbutton" value=" Login" onclick="formhash(this.form, this.form.password);">
    </form>
    <h2>
    <a href="register.php">Create Account</a><br/></br/>
    <a href="#">Forgot Password?</a>
    </h2>
    </section>
    </body>
    </html>'

