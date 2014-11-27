<?php

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


/*
 * Run the Application
 */
Slim::run();

/*
// GET route
$app->get(
  '/',
  function () {


   $app = \Slim\Slim::getInstance();

   if (checkForLogin() == true) {
    //rendering templates is not working properly.
    $app->render('home.php', array('data' => 'index page'));
    //$app->redirect('home.php');

  } else {
    $app->redirect('login.php');
  }  

}
);

$app->get(
  '/apps',
  function () {

    $app = \Slim\Slim::getInstance();

    if (checkForLogin() == true) {
      $app->redirect('myapps.php');

    } else {
      $app->redirect('login.php');

    }  
  }
  );

$app->get(
  '/apps/',
  function () {

    $app = \Slim\Slim::getInstance();

    if (checkForLogin() == true) {
      $app->redirect('appDetails.php');

    } else {
      $app->redirect('login.php');

    }  
  }
  );
// POST route
$app->post(
  '/post',
  function () {
    echo 'This is a POST route';
  }
  );

// PUT route
$app->put(
  '/put',
  function () {
    echo 'This is a PUT route';
  }
  );

// PATCH route
$app->patch('/patch', function () {
  echo 'This is a PATCH route';
});

// DELETE route
$app->delete(
  '/delete',
  function () {
    echo 'This is a DELETE route';
  }
  );

$app->run();*/

?>
