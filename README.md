# README

This is an appointment scheduler, follow these steps to run the container in docker

* Running the appointment scheduler server locally
1. In the terminal run `docker-compose build`

2. `docker-compose run --rm --service-ports ruby_dev`

3. Once within the image run this to install all dependencies and libraries `bundle update && bundle install`

4. Migrate tables `rake db:migrate` and `rake db:test:prepare`

5. To start the server run `rails server -p $PORT -b 0.0.0.0`
*note if you have any other docker images running on the same port you will need to delete them before running this

6. To create an appointment you can use postman/curl or any other tools to post into this endpoint `localhost:3000/appointments`
https://httpie.io/ this is the tool I've used and the example params are the following `http POST :3000/appointments user_id=1 date=2021-02-07 time=15:30`

7. to get a list of all the appointments made by the user go to `localhost:3000/appointments/user/user_id` where user_id is the user id that was given when creating an appointment

* Tests
1. run command `bundle exec rspec` to run all existing tests

2. To have an overview of the tests see the spec folder located at the root

* TODO
1. Test cancel and changing user's appointment endpoint
