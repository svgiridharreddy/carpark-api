# README

This README would normally document whatever steps are necessary to get the
application up and running.

Approch:

Download csv from the data source provided.
Create CarparkInfo model with the fields as per csv and load database table using rake task.
Convert SVY21 format coordinates in csv to widely used format (latitude and longitude) using SVY21 gem.
Create AvailableCarpark model with required fields as per API response.
Rake task to call the API and save the data to database.  
Refer Carparks controller for the logic.
Use Geocoder gem to get nearest carparks with given latitude and longitdue coordinates.
Use will_paginate gem for pagination.

The end point  to get desired output is '/api/caparks/nearest' with latitude and longitude values which are must to be present

example: "localhost:3000/api/carparks/nearest?latitude=1.29042987441557&longitude=103.864681788302&page=1&per_page=3"  



