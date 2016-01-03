<?php

/**
 * Class: Toilets
 *
 * Please note:
 * Don't use the same name for class and method, as this might trigger an (unintended) __construct of the class.
 * This is really weird behaviour, but documented here: http://php.net/manual/en/language.oop5.decon.php
 *
 */
class Toilets extends Controller {

  /** The display name and back-end name */
  private static $rating_categories = array(
    array('Cleanliness', 'cleanliness'),
    array('Location', 'location'),
    array('WiFi', 'wifi'),
    array('Writing', 'writing'),
    array('Traffic', 'traffic'),
    array('Toilet paper', 'toilet_paper'),
    array('Overall', 'overall')
  );

  /** Handles the page to view an individual restroom. */
	public function viewToilet($building_slug, $floor_slug, $toilet_slug) {
    $toilet = $this->model->getToilet($building_slug, $floor_slug, $toilet_slug);
    $reviews = $this->model->getReviews($toilet->id);

    $title = Helper::sanitizeHTML($toilet->name) . ' &lt; ' .
      Helper::floorName($toilet->floor_name, $toilet->level) . ' &lt; ' .
      Helper::sanitizeHTML($toilet->building_name);

    $user_has_reviewed = Helper::isLoggedIn() && $this->model->getUsersReview($toilet->id);
    $review_URL = '/' . $building_slug . '/' . $floor_slug . '/' . $toilet_slug . '/review';

    $show_verification_message = !$toilet->verified && Helper::isLoggedIn() && phpCAS::getUser() == $toilet->user;

		require APP . 'view/_templates/header.php';
		require APP . 'view/toilets/viewToilet.php';
		require APP . 'view/_templates/footer.php';
	}

  /** Handles the page to review a restroom. */
  public function review($building_slug, $floor_slug, $toilet_slug) {
    $toilet = $this->model->getToilet($building_slug, $floor_slug, $toilet_slug);
    $current_review = $this->model->getUsersReview($toilet->id);

    $title = ($current_review ? "Update" : "Add") .
      " Review &lt; " .
      Helper::sanitizeHTML($toilet->name) . " &lt; " .
      Helper::floorName($toilet->floor_name, $toilet->level) . " &lt; " .
      Helper::sanitizeHTML($toilet->building_name);

    $restroom_url = URL . $building_slug . "/" . $floor_slug . "/" . $toilet_slug;
    $review_url = $restroom_url . '/review';

    if (isset($_POST['comments'])) {
      // Confirm the data is valid.
      $error = $this->validateReviewForm($_POST);

      if (!$error) {
        // Add the review and redirect the user to the corresponding restroom.
        $this->model->addReview($_POST, phpCAS::getUser(), $toilet->id, $current_review);
    		header('Location: ' . $restroom_url);
    		exit();
      }
      // If there were errors, continue to display the form again.

    }

		require APP . 'view/_templates/header.php';
		require APP . 'view/toilets/reviewToilet.php';
		require APP . 'view/_templates/footer.php';
  }

  /** Helper method to validate the review form data. */
  private function validateReviewForm($post) {
    $error = array();

    foreach (Toilets::$rating_categories as $category) {
      if (isset($_POST[$category[1]]) && $_POST[$category[1]] != null) {
        $_POST[$category[1]] = Helper::ratingNumber($_POST[$category[1]]);
      } else {
        $_POST[$category[1]] = null;
      }
    }

    // Confirm that the user gave an overall rating.
    if (!isset($_POST['overall']) || $_POST['overall'] == null) {
  		$error['rating'] = 'You must provide an overall rating.';
  	}

    // Trim and check the length of the comment.
    $arbitrary_max_characters = 5000;
    $_POST['comments'] = trim($_POST['comments']);

    if ($_POST['comments'] == null || $_POST['comments'] == '') {
      $error['comments'] = 'Please provide a few comments about this restroom.';
    } elseif (strlen($_POST['comments']) > $arbitrary_max_characters) {
      $error['comments'] = 'This comment is too long. Please keep it under ' . $arbitrary_max_characters .
        ' characters (currently ' . strlen($_POST['comments']) . ' characters).';
    }

    return $error;
  }

  /** Handles the page to view all restrooms for a building or floor. */
	public function viewToilets($building_slug, $floor_slug=null) {

		$building = $this->model->getBuilding($building_slug);
		$floor = $this->model->getFloor($building->id, $floor_slug);

    $gender = null;
    $is_admin = false;
    if (Helper::isLoggedIn()) {
      $gender = $this->model->getGender(phpCAS::getUser());
      $is_admin = $this->model->userIsAdmin(phpCAS::getUser());
    }


    $toilets = $this->model->getToilets($building->id, (isset($floor->id) ? $floor->id : null), $gender);


		if (is_null($floor)) {
			$title = Helper::sanitizeHTML($building->name);
      $add_link = "/" . $building_slug . "/add";
		} else {
			$title = Helper::floorName($floor->name, $floor->level) . ' &lt; ' . Helper::sanitizeHTML($building->name);
      $add_link = "/" . $building_slug . "/" . $floor_slug . "/add";
		}

		require APP . 'view/_templates/header.php';
		require APP . 'view/toilets/viewToilets.php';
		require APP . 'view/_templates/footer.php';
	}

  /** Handles the page for adding a new restroom. */
  public function add($building_slug=null, $floor_slug=null) {
    if (isset($_POST['building_id'])) {
      // If the user has POSTed the form, check the data.

      // Variables that will be useful later.
      $slug = Helper::sluggify($_POST['name']);
      $floors = $this->model->getFloorsOfBuilding($_POST['building_id']);
      try {
        $current_building = $this->model->getBuildingByID($_POST['building_id']);
        $current_floor = $this->model->getFloorByID($_POST['floor_id']);
      } catch (InvalidArgumentException $e) {
        /* if the IDs are invalid, we'll handle this later. */
      }

      // Confirm the data is valid.
      $error = $this->validateAddForm($_POST);

      if (!$error) {
        // Add the restroom, email the admin, and redirect the user to it.
        $this->model->addToilet($_POST, $slug, phpCAS::getUser());
        $restroom_url = URL . $current_building->slug . "/" . $current_floor->slug . "/" . $slug;
        $this->sendAdminEmail($current_building, $current_floor, $_POST['name'], $restroom_url);
    		header('Location: ' . $restroom_url);
    		die();
      }
      // If there were errors, continue to display the form again.

    } else if ($building_slug) {
      // If we're visiting this form for the first time.
      $current_building = $this->model->getBuilding($building_slug);
      $floors = $this->model->getFloorsOfBuilding($current_building->id);

      if ($floor_slug) {
        $current_floor = $this->model->getFloor($current_building->id, $floor_slug);
      }
    }

    $buildings = $this->model->getAllBuildings();
    $title = "Add a Restroom";

		require APP . 'view/_templates/header.php';
		require APP . 'view/toilets/addToilet.php';
		require APP . 'view/_templates/footer.php';
  }

  /** Send an email to the admin notifying about the new restroom. */
  private function sendAdminEmail($building, $floor, $name, $url) {
		if (ADMIN_EMAIL != null && ADMIN_EMAIL != "") {
  		$subject = '[Poo @ CWRU] New restroom added: ' . Helper::sanitizeHTML($building->name) . ' > ' .
      Helper::floorName($floor->name, $floor->level) . ' > ' . Helper::sanitizeHTML($name);
      $message = 'URL: ' . $url;
      mail(ADMIN_EMAIL, $subject, $message);
    }
  }

  /** Helper method to validate data from the add restroom form. */
  private function validateAddForm($post) {
    $error = array();

    // Confirm that the building and floor are correct.
    try {
      $current_building = $this->model->getBuildingByID($post['building_id']);
      try {
        $current_floor = $this->model->getFloorByID($post['floor_id']);
        if ($current_floor->building_id != $post['building_id']) {
          $error['location'] = "The floor is invalid.";
        }
      } catch (InvalidArgumentException $e) {
        $error['location'] = "The floor is invalid.";
      }
    } catch (InvalidArgumentException $e) {
      $error['location'] = "The building is invalid.";
    }

    // Confirm that the name is valid.
    $slug = Helper::sluggify($post['name']);
    if ( trim($post['name']) == "") {
      $error['name'] = "The name cannot be blank.";
    } else if ($slug == "") {
      $error['name'] = "Please try a different name.";
    } else if (strlen($slug) > 100) {
      $error['name'] = "Please try a shorter name.";
    } else if (!isset($error['location'])) {
      // If the location is valid, confirm that the slug isn't already taken.
      try {
        $this->model->getToilet($current_building->slug, $current_floor->slug, $slug);
        // If this didn't throw an error, there already is a restroom with the same slug.
        $error['name'] = "That name is already taken.";
      } catch (InvalidArgumentException $e) {
        // No action; this is valid.
      }
    }

    // Confirm the gender is valid.
    if (!isset($post['gender']) || $post['gender'] == null) {
      $error['gender'] = "You must set a gender.";
    } else if (!in_array($post['gender'], array("male", "female", "other"))) {
      $error['gender'] = "The gender is invalid.";
    }

    // Confirm the sink, stall, and urinal counts are valid.
    if ($post['sinks'] === "") {
      $post['sinks'] = null;
    } else if ( !Helper::isInteger($post['sinks']) || $post['sinks'] < 0 ) {
      $error['sink'] = "Must be a non-negative integer or blank.";
    }

    if ($post['stalls'] === "") {
      $post['stalls'] = null;
    } else if ( !Helper::isInteger($post['stalls']) || $post['stalls'] < 0 ) {
      $error['stall'] = "Must be a non-negative integer or blank.";
    }

    if ($post['urinals'] === "") {
      $post['urinals'] = null;
    } else if ( $post['gender'] == 'male' && !Helper::isInteger($post['urinals']) || $post['urinals'] < 0 ) {
      $error['urinal'] = "Must be a non-negative integer or blank.";
    }

    // Confirm the comments aren't too long (arbitrary number).
    if (strlen($post['comments']) > 1000) {
      $error['comments'] = "Please write a shorter comment.";
    }

    return $error;
  }

}
