# README

This is an inventory tracking application built with a logistics company in mind. It incorporates Items and Warehouses with CRUD functionality, ability to add items to warehouse inventory, and a search bar for items and warehouses.

Here's a look at the schema:

<img width="600" alt="Screen Shot 2022-05-18 at 2 03 17 PM" src="https://user-images.githubusercontent.com/95893959/169146085-968a0792-3d61-4d2c-8ee5-19ce147fbad1.png">

* Ruby version: 2.7.4 - must be installed in order to run this app locally
* Rails version: 5.2.8 - must be installed in order to run this app locally

### I tried (and failed) to get this app working on Replit. I ran into numerous errors related to bundling and Replit's handling of the app's pg database, and documented most of the high(low)lights of the troubleshooting process in this gist: https://gist.github.com/johnny-bowman/329339942d641bd2702a63aaa1b742e3

### Luckily (or unluckily), Heroku exists!! I decided to deploy the app there so it was accessible in some way. 

#### To run this app on Heroku, simply visit: https://safe-tor-63976.herokuapp.com/

### OR

#### To run this app locally:
* Fork and clone this repo onto your machine, and navigate to the cloned project directory
* Run `$rails db:create` and `$rails db:migrate` in your terminal
* Run `$rails s` in your terminal 
* Navigate to `http://localhost:3000/` in your browser

