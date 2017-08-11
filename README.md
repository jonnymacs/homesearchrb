# HomeSearchRB

This is a simple sinatra web app to demo the zillow api

You can demo this application on [aws](http://54.91.158.68/)

# Implementation

The app is implemented with sinatra, a simple ruby framework for
building web applications.

Bootstrap is included but not really used.

jQuery is used for making an ajax request to the backend.

Rendering is done on the server side with erb.

A common httpclient called HTTParty is used to call the zillow api.

Results are parsed with the representable library.

The Money gem is used to parse money for easy formatting.

# Build / Run

If you check out this source code you can run it on your local
machine.

~~~
Install ruby-2.4.1 (via apt, brew, or rvm)
bundle install
bundle exec puma
~~~
