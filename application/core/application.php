<?php

class Application {
  /** @var null The controller */
  private $url_controller = null;

  /** @var null The method (of the above controller), often also named "action" */
  private $url_action = null;

  /** @var array URL parameters */
  private $url_params = array();

  /** Utility controllers (i.e. not for full pages) that shouldn't authenticate. */
  private $utility_controllers = array("util");

  /** Controllers that require an admin to be logged in. */
  private $admin_controllers = array("admin");

  /** Controllers that don't follow the {building}/{floor}/{toilet} URL scheme. */
  private $non_toilet_controllers = array("util", "admin");

  /** URL actions requiring the user to be logged in */
  private $actions_needing_login = array("add", "review");


  /**
   * "Start" the application:
   * Analyze the URL elements and calls the according controller/method or the fallback
   */
  public function __construct() {
    // create array with URL parts in $url
    $this->splitUrl();

    // check for controller: no controller given? then load the home page.
    if (!$this->url_controller) {
      require APP . 'controller/home.php';
      $page = new Home();
      $this->authenticate(false, $page);
      $page->index();

    } elseif (file_exists(APP . 'controller/' . $this->url_controller . '.php')) {
      // here we did check for controller: does such a controller exist?

      // if so, then load this file and create this controller
      // example: if controller would be "car", then this line would translate into: $this->car = new car();
      require APP . 'controller/' . $this->url_controller . '.php';
      $this->url_controller_name = $this->url_controller;
      $this->url_controller = new $this->url_controller();

      try {
        $should_authenticate = !in_array($this->url_controller_name, $this->utility_controllers);
        if ($should_authenticate) {
          $force_login = in_array($this->url_action, $this->actions_needing_login);
          $this->authenticate($force_login, $this->url_controller);
        }
      } catch (RuntimeException $e) {
        // Normal user blocked from admin page
        require APP . 'controller/error.php';
        $page = new Error();
        $page->adminError();
        die();
      }

      try {
        // check for method: does such a method exist in the controller ?
        if (method_exists($this->url_controller, $this->url_action)) {

          if (!empty($this->url_params)) {
              // Call the method and pass arguments to it
              call_user_func_array(array($this->url_controller, $this->url_action), $this->url_params);
          } else {
              // If no parameters are given, just call the method without parameters, like $this->home->method();
              $this->url_controller->{$this->url_action}();
          }

        } else {
          if (strlen($this->url_action) == 0) {
            // no action defined: call the default index() method of a selected controller
            $this->url_controller->index();
          }
          else {
            require APP . 'controller/error.php';
            $page = new Error();
            $page->error404();
          }
        }
      } catch (InvalidArgumentException $e) {
        require APP . 'controller/error.php';
        $page = new Error();
        $page->error404($e->getMessage());
      }
    } else {
      require APP . 'controller/error.php';
      $page = new Error();
      $page->index();
    }
  }

  /**
   * Parses and splits the URL. Possible URLs:
	 * ?login
	 * ?logout
	 *
	 * ?male
	 * ?female
	 * ?all
	 *
	 * HOME:
	 * /
   *
   * UTILITY:
   * /util/geolocation/{latitude}/{longitude}
   * /util/floordropdown/{building_id}
   *
   * ADMIN:
   * /admin/
   * /admin/verify/{toilet_id}
   * /admin/delete/{toilet_id}
	 *
	 * VIEW LIST OF TOILETS:
	 * /{building}
	 * /{building}/{floor}
	 *
	 * VIEW TOILET:
	 * /{building}/{floor}/{restroom}
	 *
	 * REVIEW TOILET:
	 * /{building}/{floor}/{restroom}/review
	 *
	 * ADD TOILET:
	 * /add
	 * /{building}/add
	 * /{building}/{floor}/add
   */
  private function splitUrl() {
    if (isset($_GET['url'])) {

      // split URL
      $url = trim($_GET['url'], '/');
      $url = filter_var($url, FILTER_SANITIZE_URL);
      $url = explode('/', $url);

      if (in_array($url[0], $this->non_toilet_controllers)) {
        // Check if it's a utility, admin, etc. page.
        $this->url_controller = $url[0];

        if (isset($url[1])) {
          $this->url_action = $url[1];

          // Rebase array keys and store the URL params
          $this->url_params = array_slice($url, 2);
        }

      } else {
        // Otherwise, we are dealing with toilets.
        // Determine if we are adding, reviewing, or viewing a toilet.
        if (in_array($url[count($url)-1], array("add", "review") )) {
          $this->url_action = array_pop($url);
        }

        if (isset($url[0]) || $this->url_action != null) {
          // The first parameter corresponds with a building.
          $this->url_controller = "Toilets";

          if ($this->url_action == null) {
            if (isset($url[2])) {
              // If the third parameter is set, then we have building, floor, and toilet.
              // Therefore, we're looking at an individual toilet.
              $this->url_action = "viewToilet";
            } else {
              // Otherwise, we're looking at a list of toilets for a building and maybe also floor.
              $this->url_action = "viewToilets";
            }
          }
        }

        // Rebase array keys and store the URL params
        $this->url_params = array_values($url);
      }

      // For debugging. uncomment this if you have problems with the URL
      // echo 'Controller: ' . $this->url_controller . '<br>';
      // echo 'Action: ' . $this->url_action . '<br>';
      // echo 'Parameters: ' . print_r($this->url_params, true) . '<br>';
    }
  }

  /**
   * Authenticates the user with CAS and fulfills setting changes (login/out and gender change).
   * $force: whether or not to require login
   * $controller: required to access the model and check what page is being visited
   */
  private function authenticate($force, $controller) {
    // Load the settings from the central config file
    require_once __DIR__ . '/../config/cas-config.php';

    // Load the CAS lib
    require_once $phpcas_path . '/CAS.php';

    // Enable debugging
    phpCAS::setDebug();

    // Initialize phpCAS
    phpCAS::client(CAS_VERSION_2_0, $cas_host, $cas_port, $cas_context);

    // Set the CA certificate that is the issuer of the cert on the CAS server
    phpCAS::setCasServerCACert($cas_server_ca_cert_path);

    // log in or out if desired
    if (isset($_REQUEST['login'])) {
    	phpCAS::forceAuthentication();
    }

    if (isset($_REQUEST['logout'])) {
    	if (!isset($_SESSION)) {
    		if (!isset($_SESSION)) {
    			session_start();
    		}
    	}
    	session_destroy();
    	phpCAS::logout(array('service'=>URL, 'url'=>URL));
    }

    if ($force) {
		  phpCAS::forceAuthentication();
	  } else {
      phpCAS::checkAuthentication();
    }

    // Raise an exception if the user has insufficient privileges for an admin page.
    if (in_array(strtolower(get_class($controller)), $this->admin_controllers)
      && (
        !Helper::isLoggedIn() ||
        !$controller->model->userIsAdmin(phpCAS::getUser())
      ) ) {
      // Sorry about using runtime, but I don't really want to subclass anything :/
      throw new RuntimeException("Must log in as admin.");
    }

    if (Helper::isLoggedIn()) {
      if (isset($_REQUEST['male']))
        $gender = 'male';
      elseif (isset($_REQUEST['female']))
        $gender = 'female';
      elseif (isset($_REQUEST['all']))
        $gender = 'both';

      if (isset($gender)) {
        $controller->model->setGender($gender, phpCAS::getUser());
      }
    }
  }
}
