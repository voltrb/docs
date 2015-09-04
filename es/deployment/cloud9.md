# Cloud9

Para empezar en cloud9, crea una imagen de rails (esta imagen contiene lo que necesitamos). Una vez encendido, elimina el proyecto:

```rm -rf *```

Primero configuremos mongo (revisa la documentación completa para mongo aquí)

Inicia una nueva terminal y digita lo siguiente:

```
mkdir data
echo 'mongod --bind_ip=$IP --dbpath=data --nojournal --rest "$@"' > mongod
chmod a+x mongod
```

Luego puedes correr mongod con el siguiente comando:

```
./mongod
```

Luego instalaremos Volt.

```gem install volt```

Y crearemos un nuevo proyecto:

```volt new projectname```

ingresamos al proyecto:

```cd projectname```

Y arrancamos el servidor (en Cloud9, debes pasar el puerto y la ip del ENV)

```bundle exec volt server -p $PORT -b $IP```

Cloud9 proveé un subdominio para cada aplicación, para visitar la aplicación has click en ```Preview``` y luego en ```Preview Running Application```

En la versión gratuita de Cloud9, tu base mongo se apagará periódicamente (no de forma correcta).Puedes crear una base Mongo gratuita en www.mongolab.com.  Crea una cuenta gratuita en mongolab y luego añade lo siguiente en config/app.rb

```
config.db_driver = 'mongo'
config.db_name = (config.app_name + '_' + Volt.env.to_s)
if ENV['MONGOHQ_URL'].present?```
  config.db_uri = ENV['MONGOHQ_URL'] # you will have to set this on Cloud9.
else
  config.db_host = 'localhost'
  config.db_port = 27017
end
```

NOTA: Si alguien puede crear una imagen customizada de Volt para cloud9, por favor hágamelo saber en el chat de gitter. Gracias!
