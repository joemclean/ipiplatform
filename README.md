IPI Platform

Created by: 
Joe McLean
Danielle Christophe
Kirk Shillingford
Meg Durlak
Mike Varona
Sung Yang

2013 Thoughtworks

Expanded and tested by:
Aubrey Chipman
Jeff Wagner
Karlyn Murphy
Dexter Teng
Alberto Saavedra

Requires:

brew install imagemagick

brew install phantomjs

To populate heroku's environment variables with S3 credentials (make sure config/application.yml exists) do:

rake figaro:heroku[ipiplatform]

To drop the database in heroku do
heroku pg:reset DATABASE

To run migrations and populate database
heroku run rake db:setup
