## Heroku

Edita tu ```Gemfile``` y especifica tu versión de ruby, por ejemplo:

```ruby
source 'https://rubygems.org'

ruby "2.1.3" # specify a Ruby version

gem 'volt', ~> '0.9.0'
```

Añade un ```Procfile``` que use Thin

    web: bundle exec thin start -p $PORT -e $RACK_ENV

Configura tu conección a la base de datos en ```config/app.rb```, a continuación podemos ver un ejemplo para conectar con MongoHQ. Tienes que cambiarlo para el proveedor que usarás.
[MongoLab](http://www.mongolab.com) es una alternativa gratuita.
