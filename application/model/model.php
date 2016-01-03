<?php

class Model {
  /**
   * @param object $db A PDO database connection
   */
  function __construct($db) {
    try {
      $this->db = $db;
    } catch (PDOException $e) {
      exit('Database connection could not be established.');
    }
  }

  /**
   * Get all toilets from database
   */
  public function getAllToilets() {
    $sql = "SELECT * FROM toilets";
    $query = $this->db->prepare($sql);
    $query->execute();

    return $query->fetchAll();
  }

  public function getUnverifiedToilets() {
    $sql = "SELECT t.name, t.id, t.slug, t.gender, b.name AS building_name, b.slug AS building_slug,
      f.name AS floor_name, f.level, f.slug AS floor_slug
  		FROM toilets t
  		JOIN floors f ON t.floor_id = f.id
  		JOIN buildings b ON t.building_id = b.id
  		WHERE t.verified = 0";
    $query = $this->db->prepare($sql);
    $query->execute();

    return $query->fetchAll();
  }

  public function verifyToilet($toilet_id) {
    $sql = "UPDATE toilets SET verified = true WHERE id = :toilet_id";
    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id);
    $query->execute($parameters);
  }

  public function deleteToiletAndReviews($toilet_id) {
    $sql = "DELETE FROM toilets WHERE id = :toilet_id";
    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id);
    $query->execute($parameters);

    $sql = "DELETE FROM reviews WHERE toilet_id = :toilet_id";
    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id);
    $query->execute($parameters);
  }


  /**
   * Get a toilet from database. Raises an IllegalArgumentException if it cannot be found.
   */
  public function getToilet($building_slug, $floor_slug, $toilet_slug) {
    $sql = "SELECT t.id, t.name, t.slug, b.name as building_name, b.slug as building_slug,
        f.name as floor_name, f.level, f.slug as floor_slug, t.gender, t.verified, t.user,
        t.stalls, t.urinals, t.sinks, AVG(r.cleanliness) as cleanliness, AVG(r.location) as location,
        AVG(r.wifi) as wifi, AVG(r.writing) as writing, AVG(r.traffic) as traffic, AVG(r.toilet_paper) as tp,
        AVG(r.overall) as overall, COUNT(r.overall) as reviews, t.comments
      FROM toilets t
      JOIN buildings b ON b.id = t.building_id
      JOIN floors f ON f.id = t.floor_id
      LEFT JOIN reviews r ON r.toilet_id = t.id
      WHERE b.slug = :building_slug AND f.slug = :floor_slug AND t.slug = :toilet_slug";
    $query = $this->db->prepare($sql);
    $parameters = array(':building_slug' => $building_slug,
                        ':floor_slug' => $floor_slug,
                        ':toilet_slug' => $toilet_slug);

    // useful for debugging: you can see the SQL behind above construction by using:
    // echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

    $query->execute($parameters);

    // fetch() is the PDO method that get exactly one result
    $result = $query->fetch();
    if (!$result->id) {
			throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that restroom.");
		}
    return $result;
  }

  /**
   * Get a toilet from database. Raises an IllegalArgumentException if it cannot be found.
   */
  public function getToiletByID($toilet_id) {
    $sql = "SELECT t.id, t.name, t.slug, b.name as building_name, b.slug as building_slug,
        f.name as floor_name, f.level, f.slug as floor_slug, t.gender, t.verified,
        t.stalls, t.urinals, t.sinks, AVG(r.cleanliness) as cleanliness, AVG(r.location) as location,
        AVG(r.wifi) as wifi, AVG(r.writing) as writing, AVG(r.traffic) as traffic, AVG(r.toilet_paper) as tp,
        AVG(r.overall) as overall, COUNT(r.overall) as reviews, t.comments
      FROM toilets t
      JOIN buildings b ON b.id = t.building_id
      JOIN floors f ON f.id = t.floor_id
      LEFT JOIN reviews r ON r.toilet_id = t.id
      WHERE t.id = :toilet_id";
    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id);

    // useful for debugging: you can see the SQL behind above construction by using:
    // echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

    $query->execute($parameters);

    // fetch() is the PDO method that get exactly one result
    $result = $query->fetch();
    if (!$result->id) {
			throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that restroom.");
		}
    return $result;
  }

  /** Returns all reviews for a specific restroom. */
  public function getReviews($toilet_id) {
    $sql = "SELECT comments, datetime, user
      FROM reviews r
    	WHERE toilet_id = :toilet_id
    	ORDER BY r.datetime DESC";

    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id);

    // useful for debugging: you can see the SQL behind above construction by using:
    // echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

    $query->execute($parameters);

    return $query->fetchAll();
  }

  /** Returns all restrooms for a building or floor. Optionally filters by gender. */
	public function getToilets($building_id, $floor_id=null, $gender=null) {
    $floor_statement = "";
    if (isset($floor_id)) {
			$floor_statement = " AND t.floor_id = :floor_id ";
		}
    // If a specific gender is set, filter out the ineligible restrooms.
    $gender_statement = "";
    if (isset($gender)) {
      if ($gender == "male") {
        $gender_statement = ' AND t.gender !=  "female"';
      } else if ($gender == "female") {
        $gender_statement = ' AND t.gender !=  "male"';
      }
    }

    $sql = "SELECT t.name, t.slug, t.gender, AVG(r.overall) AS rating,
      COUNT(r.overall) AS ratings, b.name AS building_name, b.slug AS building_slug,
      f.name AS floor_name, f.level, f.slug AS floor_slug, t.verified, t.user
				FROM toilets t
				JOIN floors f ON t.floor_id = f.id
				JOIN buildings b ON t.building_id = b.id
				LEFT JOIN reviews r ON t.id = r.toilet_id
				WHERE t.building_id = :building_id "
				. $floor_statement . $gender_statement .
				"GROUP BY t.id
				ORDER BY f.level ASC, rating DESC";

		$query = $this->db->prepare($sql);
		$parameters = array(':building_id' => $building_id);
    if (isset($floor_id)) {
			$parameters[':floor_id'] = $floor_id;
		}

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

		// fetch() is the PDO method that get exactly one result
		return $query->fetchAll();
	}

  public function getAllBuildings() {
    $sql = "SELECT slug, name, id FROM buildings ORDER BY name ASC";

    $query = $this->db->prepare($sql);
    $query->execute();
    return $query->fetchAll();
  }

  /** Gets buildings that are either "north" or "south" of Euclid. */
  public function getBuildingsByLocation($location) {
    if (in_array($location, array("north", "south"))) {
      $sql = "SELECT slug, name, id
        FROM buildings
        WHERE location = :location
        ORDER BY name ASC";

      $query = $this->db->prepare($sql);
      $parameters = array(':location' => $location);
      $query->execute($parameters);
      return $query->fetchAll();
    } else {
      throw new InvalidArgumentException("Invalid location.");
    }
  }

  public function getNearbyBuildings($latitude, $longitude, $max_distance) {
    // https://developers.google.com/maps/articles/phpsqlsearch_v3#findnearsql
    $sql = "SELECT id, name, slug,
      ( 3959 * acos( cos( radians(:latitude) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(:longitude) ) + sin( radians(:latitude_again) ) * sin( radians( latitude ) ) ) ) AS distance
      FROM buildings HAVING distance < :distance ORDER BY distance ASC LIMIT 0 , 5";

    $query = $this->db->prepare($sql);
    $parameters = array(':latitude' => $latitude,
      ':longitude' => $longitude,
      ':latitude_again' => $latitude,
      ':distance' => $max_distance
    );

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

    return $query->fetchAll();
  }

  /** Gets a building by slug. Raises an InvalidArgumentException if it cannot be found. */
  public function getBuilding($building_slug) {
		$sql = "SELECT name, id, blurb FROM buildings WHERE slug = :building_slug";

		$query = $this->db->prepare($sql);
		$parameters = array(':building_slug' => $building_slug);

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

		// fetch() is the PDO method that get exactly one result
		$result = $query->fetch();
    if (!$result) {
      throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that building.");
    }
    return $result;
	}

  /** Gets a building by ID. Raises an InvalidArgumentException if it cannot be found. */
  public function getBuildingByID($building_id) {
    $sql = "SELECT id, name, blurb, slug FROM buildings WHERE id = :building_id";

    $query = $this->db->prepare($sql);
    $parameters = array(':building_id' => $building_id);

    // useful for debugging: you can see the SQL behind above construction by using:
    // echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

    $query->execute($parameters);

    // fetch() is the PDO method that get exactly one result
		$result = $query->fetch();
    if (!$result) {
      throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that building.");
    }
    return $result;
  }

  /** Gets a floor by ID. Raises an InvalidArgumentException if it cannot be found. */
  public function getFloorByID($floor_id) {
    $sql = "SELECT name, id, level, building_id, slug FROM floors WHERE id = :floor_id";

		$query = $this->db->prepare($sql);
		$parameters = array(':floor_id' => $floor_id);

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

		// fetch() is the PDO method that get exactly one result
		$result = $query->fetch();
    if (!$result) {
      throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that floor.");
    }
    return $result;
  }

  /** Gets a floor by slugs. Raises an InvalidArgumentException if it cannot be found. */
	public function getFloor($building_id, $floor_slug) {
		if (is_null($floor_slug)) {
			return null;
		}

		$sql = "SELECT name, id, level, building_id FROM floors WHERE building_id = :building_id AND slug = :floor_slug";

		$query = $this->db->prepare($sql);
		$parameters = array(':building_id' => $building_id, ':floor_slug' => $floor_slug);

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

		// fetch() is the PDO method that get exactly one result
		$result = $query->fetch();
    if (!$result) {
      throw new InvalidArgumentException("Sorry, but I couldn&rsquo;t find that floor.");
    }
    return $result;
	}

  public function getFloorsOfBuilding($building_id) {
    $sql = "SELECT name, id, level FROM floors WHERE building_id = :building_id ORDER BY level ASC";

		$query = $this->db->prepare($sql);
		$parameters = array(':building_id' => $building_id);

		// useful for debugging: you can see the SQL behind above construction by using:
		// echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

		$query->execute($parameters);

		// fetch() is the PDO method that get exactly one result
		return $query->fetchAll();
  }


  public function addToilet($post, $slug, $user) {

    $sql = "INSERT INTO toilets
			(name, slug, gender, building_id, floor_id, stalls, urinals, sinks,
        comments, user, verified, updated)
      VALUES
      (:name, :slug, :gender, :building_id, :floor_id, :stalls, :urinals, :sinks,
        :comments, :user, 0, CURRENT_TIMESTAMP)";

    $query = $this->db->prepare($sql);
    $parameters = array(
      ':name' => $_POST['name'],
      ':slug' => $slug,
      ':gender' => $_POST['gender'],
      ':building_id' => $_POST['building_id'],
      ':floor_id' => $_POST['floor_id'],
      ':stalls' => $_POST['stalls'],
      ':urinals' => $_POST['urinals'],
      ':sinks' => $_POST['sinks'],
      ':comments' => $_POST['comments'],
      ':user' => $user
    );

    $query->execute($parameters);
  }


	public function getGender($user) {
    $sql = "SELECT gender FROM users WHERE case_id = :user";

		$query = $this->db->prepare($sql);
		$parameters = array(':user' => $user);
		$query->execute($parameters);

		return $query->fetch()->gender;
	}

  public function setGender($gender, $user) {
    if ($gender != 'male' && $gender != 'female' && $gender != 'both')
      throw IllegalArgumentException('Invalid gender.');

    // If no user, don't do anything.
    if ($user == null || trim($user) == '')
      return;

    $sql = "SELECT * FROM users WHERE case_id = :user";
    $query = $this->db->prepare($sql);
    $parameters = array(':user' => $user);
    $query->execute($parameters);
    $result = $query->fetch();

    if ($result == false) {
      $sql = "INSERT INTO users (case_id, joined) VALUES (:user, CURRENT_TIMESTAMP)";

      $query = $this->db->prepare($sql);
      $parameters = array(':user' => $user);

      $query->execute($parameters);
    } else {
      $sql = "UPDATE users SET gender = :gender WHERE case_id = :user";

      $query = $this->db->prepare($sql);
      $parameters = array(':gender' => $gender, ':user' => $user);

      //echo '[ PDO DEBUG ]: ' . Helper::debugPDO($sql, $parameters);  exit();

      $query->execute($parameters);
    }
  }

  // Sets the gender of a user.
  public function addUserIfNotAdded($user) {
    // If no user, don't do anything.
    if ($user == null || trim($user) == '')
      return;

    $sql = "SELECT * FROM users WHERE case_id = :user";
		$query = $this->db->prepare($sql);
		$parameters = array(':user' => $user);
		$query->execute($parameters);
		$result = $query->fetch();

    if ($result == false) {
      $sql = "INSERT INTO users (case_id, joined) VALUES (:user, CURRENT_TIMESTAMP)";

      $query = $this->db->prepare($sql);
      $parameters = array(':user' => $user);

      $query->execute($parameters);
    }
  }

  public function userIsAdmin($user) {
    $sql = "SELECT admin FROM users WHERE case_id = :user";

		$query = $this->db->prepare($sql);
		$parameters = array(':user' => $user);
		$query->execute($parameters);

		return $query->fetch()->admin;
  }

  public function getUsersReview($toilet_id) {
    if (!Helper::isLoggedIn()) {
      return null;
    }
    $user = phpCAS::getUser();

    $sql = "SELECT id, cleanliness, location, wifi, writing, traffic, toilet_paper, overall, comments
      FROM reviews r
    	WHERE toilet_id = :toilet_id
      AND user = :user";

    $query = $this->db->prepare($sql);
    $parameters = array(':toilet_id' => $toilet_id, ':user' => $user);

    $query->execute($parameters);
    return $query->fetch();
  }

  public function addReview($post, $user, $toilet_id, $previous_review) {
    if ($previous_review) {
      $sql = "UPDATE reviews SET
        datetime = CURRENT_TIMESTAMP,
        cleanliness = :cleanliness,
        location = :location,
        wifi = :wifi,
        writing = :writing,
        traffic = :traffic,
        toilet_paper = :toilet_paper,
        overall = :overall,
        comments = :comments
        WHERE id = :id";

      $query = $this->db->prepare($sql);
      $parameters = array(
        ':cleanliness' => $post['cleanliness'],
        ':location' => $post['location'],
        ':wifi' => $post['wifi'],
        ':writing' => $post['writing'],
        ':traffic' => $post['traffic'],
        ':toilet_paper' => $post['toilet_paper'],
        ':overall' => $post['overall'],
        ':comments' => $post['comments'],
        ':id' => $previous_review->id
      );

    } else {
      $sql = "INSERT INTO reviews
        (toilet_id, cleanliness, location, wifi, writing, traffic,
          toilet_paper, overall, comments, user)
        VALUES
        (:toilet_id, :cleanliness, :location, :wifi, :writing, :traffic,
          :toilet_paper, :overall, :comments, :user)";

      $query = $this->db->prepare($sql);
      $parameters = array(
        ':toilet_id' => $toilet_id,
        ':cleanliness' => $post['cleanliness'],
        ':location' => $post['location'],
        ':wifi' => $post['wifi'],
        ':writing' => $post['writing'],
        ':traffic' => $post['traffic'],
        ':toilet_paper' => $post['toilet_paper'],
        ':overall' => $post['overall'],
        ':comments' => $post['comments'],
        ':user' => $user
      );
    }

    $query->execute($parameters);
  }
}
