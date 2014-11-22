
## Logging

Volt provides a helper for logging.  Calling ```Volt.logger``` returns an instance of the ruby logger.  See [here](http://www.ruby-doc.org/stdlib-2.1.3/libdoc/logger/rdoc/Logger.html) for more.

```ruby
Volt.logger.info("Some info...")
```

You can change the logger with:

```ruby
Volt.logger = Logger.new
```

## App Configuration

Like many frameworks, Volt changes some default settings based on an environment flag.  You can set the volt environment with the VOLT_ENV environment variable.

All files in the app's ```config``` folder are loaded when Volt boots.  This is similar to the ```initializers``` folder in Rails.

Volt does its best to start with useful defaults.  You can configure things like your database and app name in the config/app.rb file.  The following are the current configuration options:

| name      | default                   | description                                                   |
|-----------|---------------------------|---------------------------------------------------------------|
| app_name  | the current folder name   | This is used internally for things like logging.              |
| db_driver | 'mongo'                   | Currently mongo is the only supported driver, more coming soon|
| db_name   | "#{app_name}_#{Volt.env}  | The name of the mongo database.                               |
| db_host   | 'localhost'               | The hostname for the mongo database.                          |
| db_port   | 27017                     | The port for the mongo database.                              |
| compress_deflate | false              | If true, will run deflate in the app server, its better to let something like nginx do this though |
