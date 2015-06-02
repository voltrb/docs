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


NOTE: if anyone wants to create a custom Volt imagge for cloud9, please let @ryanstout know in the gitter room.  Thanks!
