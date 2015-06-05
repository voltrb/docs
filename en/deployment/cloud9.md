# Cloud9

To get started on cloud9, boot up a rails image (since it has everything we need).  Once booted, remove the existing project:

```rm -rf *```

First lets setup mongo (see the full docs on running mongo here).

Start a new terminal and enter the following:

```
mkdir data
echo 'mongod --bind_ip=$IP --dbpath=data --nojournal --rest "$@"' > mongod
chmod a+x mongod
```

Then you can run mongod with:

```
./mongod
```

Next lets install volt.

```gem install volt```

Then create a new project:

```volt new projectname```

cd into the project:

```cd projectname```

And start the server (on cloud9, you must pass in the port and ip from ENV's)

```bundle exec volt server -p $PORT -b $IP```

Cloud9 will give each app a custom sub-domain, to visit the running app, click the ```Preview``` menu, then ```Preview Running Application```

At least with the free version on Cloud9, your mogoDB may be uncleanly shut down periodically. You can set up a free Monogo store on www.mongolab.com instead as an alternative. Set up an account there, then add the following to your config/app.rb:

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


NOTE: if anyone wants to create a custom Volt imagge for cloud9, please let @ryanstout know in the gitter room.  Thanks!
