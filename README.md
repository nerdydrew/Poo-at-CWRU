# Poo at CWRU
### A website to find and rate restrooms on campus
This is the source code for [pooatcwru.com](https://pooatcwru.com). I originally wrote it around August 2014. In January 2016 I cleaned it up, rewrote some portions, and released it on GitHub. In December 2018 I rewrote it again in Ruby on Rails.

## Installation
* Clone the repo.
* Install necessary libraries (like `gem install bundler`).
* Run `bundle install`.
* Configure the user and databases in `config/database.yml`.
* Run `rails db:migrate`.
* Run `rails db:seed` to load building and floor info.
* Run `rails server`.
* Access the website at `localhost:3000`.

## References
* Buildings / Restrooms
	* https://webapps.case.edu/map/
	* https://case.edu/library/spaces/interactive-map
	* https://case.edu/lgbt/resources/transgender-resources/bathroom-inventory
* Central Authentication Service (Single Sign-On)
	* http://hacsoc.org/wiki/technical/cas.html
	* https://web.archive.org/web/20121126051658/http://wiki.case.edu/Central_Authentication_Service