<?php

/**
 * Class Util
 *
 * Please note:
 * Don't use the same name for class and method, as this might trigger an (unintended) __construct of the class.
 * This is really weird behaviour, but documented here: http://php.net/manual/en/language.oop5.decon.php
 *
 */
class Util extends Controller {
	/** Handles the HTML to display nearby buildings. */
	public function geolocation($latitude, $longitude) {
		$max_distance = 2; // miles
		$buildings = $this->model->getNearbyBuildings($latitude, $longitude, $max_distance);

		// load view
		require APP . 'view/util/geolocation.php';
	}

	/**
	* Handles the HTML for the dropdown menu of floors (used when changing the
	* building on the add restroom form).
	*/
	public function floordropdown($building_id) {
		$floors = $this->model->getFloorsOfBuilding($building_id);
		// load view
		require APP . 'view/util/floordropdown.php';
	}
}
