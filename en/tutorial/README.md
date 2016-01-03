# Tutorial

This guide will take you through creating a basic web application in Volt.  This tutorial assumes a basic knowledge of Ruby and web development.

## Setup

First, let's install Volt and create an empty app.  Be sure you have ruby (>2.1.0) and rubygems installed.

Next install the volt gem:

    gem install volt

Using the volt gem, we can create a new project:

    volt new sample_project

This will setup a basic project in the sample_project folder.  We can ```cd``` into the folder and run the server:

    bundle exec volt server

Lastly, we can access the Volt console with:

    bundle exec volt console

## Installation under Windows

While doing ```gem install volt```, you might get the error message:

```
ERROR:  While executing gem ... (Gem::RemoteFetcher::FetchError)
    bad response Not Found 404 (https://rubygems.global.ssl.fastly.net/quick/Marshal.4.8/pry-0.10.1-x86-mingw32.gemspec.rz)
```

In that case you've hit a road block with the Pry gem in Windows (https://github.com/rubygems/rubygems/issues/1120).

What worked for me to get a working version of Pry installed, is to create a Gemfile into a new directory with the following dependencies:

```
source 'https://rubygems.org'

gem 'volt', '0.9.4'
gem 'volt-mongo'
gem 'thin', '~> 1.6.0'
gem 'bson_ext', '~> 1.9.0'

gem 'volt-bootstrap', '~> 0.0.10'

gem 'volt-bootstrap_jumbotron_theme', '~> 0.1.0'

gem 'volt-user_templates', '~> 0.1.3'

group :development, :test do
  gem 'rspec', '~> 3.2.0'
  gem 'opal-rspec', '~> 0.4.2'
  gem 'capybara', '~> 2.4.2'
  gem 'selenium-webdriver', '~> 2.43.0'
  gem 'chromedriver2-helper', '~> 0.0.8'
  gem 'poltergeist', '~> 1.5.0'
end
```
And then run ```bundle install``` to have all dependencies installed (this will use the mingw32 version of Pry).
