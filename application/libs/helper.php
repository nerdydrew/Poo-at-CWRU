<?php

class Helper {
	/**
	 * debugPDO
	 *
	 * Shows the emulated SQL query in a PDO statement. What it does is just extremely simple, but powerful:
	 * It combines the raw query and the placeholders. For sure not really perfect (as PDO is more complex than just
	 * combining raw query and arguments), but it does the job.
	 *
	 * @author Panique
	 * @param string $raw_sql
	 * @param array $parameters
	 * @return string
	 */
	static public function debugPDO($raw_sql, $parameters) {

		$keys = array();
		$values = $parameters;

		foreach ($parameters as $key => $value) {

			// check if named parameters (':param') or anonymous parameters ('?') are used
			if (is_string($key)) {
				$keys[] = '/' . $key . '/';
			} else {
				$keys[] = '/[?]/';
			}

			// bring parameter into human-readable format
			if (is_string($value)) {
				$values[$key] = "'" . $value . "'";
			} elseif (is_array($value)) {
				$values[$key] = implode(',', $value);
			} elseif (is_null($value)) {
				$values[$key] = 'NULL';
			}
		}

		/*
		echo "<br> [DEBUG] Keys:<pre>";
		print_r($keys);

		echo "\n[DEBUG] Values: ";
		print_r($values);
		echo "</pre>";
		*/

		$raw_sql = preg_replace($keys, $values, $raw_sql, 1, $count);

		return $raw_sql;
	}

	// Prepares text to be displayed in HTML.
	public static function sanitizeHTML($str) {
		if(get_magic_quotes_gpc()){
			$str = stripslashes($str);
			// strip off the slashes if they are magically added.
		}
		return htmlentities($str, ENT_QUOTES, 'UTF-8');
	}

	// Returns a boolean of if the input is an integer or string of an int (e.g. "5").
	public static function isInteger($i) {
		return is_numeric($i) && round($i) == $i;
	}

	// Returns whether or not the user is logged in. Notice: authenticate() must have been called
	// already before calling this function, or else it will throw an exception.
	public static function isLoggedIn() {
		return class_exists("phpCAS") && phpCAS::isSessionAuthenticated();
	}

	// Replaces the gender with a symbol.
	public static function gender($g) {
		if ($g == 'male')
			return '<span class="male" title="male">&#9794;</span>';
		elseif ($g == 'female')
			return '<span class="female" title="female">&#9792;</span>';
		else
			return '<span class="bothGenders" title="Any gender may use this restroom.">Any</span>';
	}

	// Convert a string into a slug for use in URLs.
	public static function sluggify($str) {
		$str = trim(strtolower($str));
		$str = preg_replace("/[^A-Za-z0-9 ]/", '', $str);
		$str = preg_replace("!\s+!", "-", $str);
		return $str;
	}

	// Takes in a number and returns a string of the appropriate amount of stars.
	public static function ratingStars($rating) {
		return Helper::ratingStarsWithNumberOfRatings($rating, 0);
	}

	// Adjusts the title.
	public static function ratingStarsWithNumberOfRatings($rating, $numberOfRatings) {
		$rating = Helper::ratingNumber($rating);
		if ($rating == null) {
			return '<span title="Not yet rated">N/A</span>';
		}

		$title = ($rating == 1 ? 'One star' : $rating . ' stars');
		if ($numberOfRatings > 0)
			$title .= ' from ' . ($numberOfRatings == 1 ? '1 review' : $numberOfRatings . ' reviews');


		$stars = '<span class="stars" title="' . $title . '" data-label="' . $rating . '&#9733;">';
		for ($i=0; $i<$rating; $i++) {
			$stars .= '&#9733;';
		}
		return $stars . '</span>';
	}

	/** Validates the value used as a rating. */
	public static function ratingNumber($rating) {
		if ($rating == null || $rating == '')
			return null;
		else if ($rating < 1)
			return 1;
		else if ($rating > 5)
			return 5;
		else
			return round($rating);
	}

	/** Determines the display name for a floor. Uses high-tech string comparison technology. */
	public static function floorName($floorName, $level) {
		// If a floor name is set
		if ($floorName != null) {
			// Expand out a few specific names
			if ($floorName == 'LL')
				return 'Lower Level';

			if($floorName == 'B1')
				return 'Basement 1';

			// If it's not special, just return the normal name.
			return $floorName;
		}

		return Helper::ordinal($level) . ' Floor';
	}

	// e.g. for narrow columns
	public static function floorNameShort($floorName, $level) {
		return ($floorName !=null ? $floorName : Helper::ordinal($level));
	}

	public static function ordinal($x) {
		$nf = new NumberFormatter('en_US', NumberFormatter::ORDINAL);
		return $nf->format($x);
	}

	// returns a string stating the distance away.
	public static function distance($miles) {
		if (!is_numeric($miles))
			throw new InvalidArgumentException('"' . $miles . '" must be a number.');

		if ($miles < 0)
			$miles *= -1;

		if ($miles >= 1)
			return round($miles) . ' miles';
		else
			return round($miles * 5280) . ' feet';
	}

}
