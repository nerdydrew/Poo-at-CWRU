<?php

/**
 * Class Error
 *
 * Please note:
 * Don't use the same name for class and method, as this might trigger an (unintended) __construct of the class.
 * This is really weird behaviour, but documented here: http://php.net/manual/en/language.oop5.decon.php
 *
 */
class Error extends Controller {
  /** This method handles the page for a general error. */
  public function index($message=null) {
    $title = "Error";
    header("HTTP/1.1 500 Internal Server Error");
    require APP . 'view/_templates/header.php';
    require APP . 'view/error/index.php';
    require APP . 'view/_templates/footer.php';
  }

  /** This method handles the page for a 404 error. */
	public function error404($message=null) {
    $title = "404 Error";
  	header("HTTP/1.1 404 Not Found");
    require APP . 'view/_templates/header.php';
    require APP . 'view/error/error404.php';
    require APP . 'view/_templates/footer.php';
	}

  /** This method handles when a normal user tries to perform admin actions. */
  public function adminError() {
    $title = "401 Error (Unauthorized)";
  	header("HTTP/1.1 401 Unauthorized");
    require APP . 'view/_templates/header.php';
    require APP . 'view/error/error401.php';
    require APP . 'view/_templates/footer.php';
  }
}
