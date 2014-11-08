## Heroku

Edit your Gemfile to specify Ruby version, e.g

```ruby
    source 'https://rubygems.org'

    ruby "2.1.3" # specify a Ruby version

    gem 'volt', '0.8.18'
```


Add a Procfile that uses Thin

    web: bundle exec thin start -p $PORT -e $RACK_ENV
