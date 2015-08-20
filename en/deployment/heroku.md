## Heroku

Edit your ```Gemfile``` to specify Ruby version, e.g.

```ruby
source 'https://rubygems.org'

ruby "2.1.3" # specify a Ruby version

gem 'volt', ~> '0.9.0'
```

Add a ```Procfile``` that uses Thin

    web: bundle exec thin start -p $PORT -e $RACK_ENV

Set up your data store connection in ```config/app.rb```.
Below you see an example for MongoHQ. You'll need to adapt for your provider.
[MongoLab](http://www.mongolab.com) is a great free solution.

```ruby
config.db_driver = 'mongo'
config.db_name = (config.app_name + '_' + Volt.env.to_s)

if ENV['MONGOHQ_URL'].present?
  config.db_uri = ENV['MONGOHQ_URL'] # you will have to set this on heroku
else
  config.db_host = 'localhost'
  config.db_port = 27017
end
```
