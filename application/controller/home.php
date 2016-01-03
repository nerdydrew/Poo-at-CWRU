<?php

/**
 * Class Home
 *
 * Please note:
 * Don't use the same name for class and method, as this might trigger an (unintended) __construct of the class.
 * This is really weird behaviour, but documented here: http://php.net/manual/en/language.oop5.decon.php
 *
 */
class Home extends Controller {
  /** This method handles the home page. */
  public function index() {
    $north_buildings = $this->model->getBuildingsByLocation("north");
    $south_buildings = $this->model->getBuildingsByLocation("south");

    require APP . 'view/_templates/header.php';
    require APP . 'view/home/index.php';
    require APP . 'view/_templates/footer.php';
  }
}
