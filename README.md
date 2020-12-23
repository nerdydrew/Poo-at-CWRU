# Poo at CWRU
### A website to find and rate restrooms on campus
This is the source code for [pooatcwru.com](https://pooatcwru.com). I originally wrote it around August 2014. In January 2016 I cleaned it up, rewrote some portions, and released it on GitHub. In December 2018 I rewrote it again in Ruby on Rails.

## Installation
* Clone the repo.
* Install necessary libraries (like `gem install bundler`).
* Run `bundle install`.
* Configure the user and databases in `config/database.yml`.
* Run `rails db:migrate`.
* Run `rails db:seed:load` to load building and floor info.
* Run `rails server`.
* Access the website at `localhost:3000`.

## Acknowledgements
* Inspiration for this project came from a detailed rating system graffitied onto a bathroom wall in a CWRU building, which has been [saved for posterity on Reddit](https://www.reddit.com/r/cwru/comments/2anjrp/i_poop_in_one_of_the_quad_buildings_every_morning/).
* Coordinates of CWRU buildings came from [case.edu/maps](https://webapps.case.edu/map/).