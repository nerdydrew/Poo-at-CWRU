<?php

/**
 * Class Admin
 *
 * Please note:
 * Don't use the same name for class and method, as this might trigger an (unintended) __construct of the class.
 * This is really weird behaviour, but documented here: http://php.net/manual/en/language.oop5.decon.php
 *
 */
class Admin extends Controller {
  /** This method handles the admin home page. */
  public function index() {
    $title = "Administration";
    $toilets = $this->model->getUnverifiedToilets();

    require APP . 'view/_templates/header.php';
    require APP . 'view/admin/index.php';
    require APP . 'view/_templates/footer.php';
  }

  public function verify($toilet_id) {
    $title = "Verify Restroom";
    $toilet = $this->model->getToiletByID($toilet_id);
    $toilet_url = URL . $toilet->building_slug . '/' . $toilet->floor_slug . '/' . $toilet->slug;

    $this->model->verifyToilet($toilet_id);

    require APP . 'view/_templates/header.php';
    require APP . 'view/admin/verify.php';
    require APP . 'view/_templates/footer.php';
  }

  public function delete($toilet_id, $sure=false) {
    if ($sure) {
      $this->model->deleteToiletAndReviews($toilet_id);
      header("Location: " . URL . "admin/");
    } else {
      $title = "Delete Restroom";
      $toilet = $this->model->getToiletByID($toilet_id);
      $toilet_url = URL . $toilet->building_slug . '/' . $toilet->floor_slug . '/' . $toilet->slug;

      require APP . 'view/_templates/header.php';
      require APP . 'view/admin/delete.php';
      require APP . 'view/_templates/footer.php';
    }
  }
}
