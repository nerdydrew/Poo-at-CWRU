# Poo at CWRU
### A website to find and rate restrooms on campus
This is the source code for [pooatcwru.com] (http://pooatcwru.com). I originally wrote it around August 2014. In January 2016 I cleaned it up, rewrote some portions, and released it on GitHub.

## Installation
* Clone the repo.
* Create a SQL database and set it up using `sql_dump.sql`. 
* Find `config-example.php` within `/application/config/`, rename it to `config.php`, and fill in the database info.

## Acknowledgements
This code is written on the [MINI framework] (https://github.com/panique/mini/). This repo also includes [phpCAS] (https://github.com/Jasig/phpCAS) for authentication with single sign-on.
