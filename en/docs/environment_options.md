# Environment Options

In addition to the options in config/app.rb, some instance specific options in Volt can be configured with instance variables.

| Name                   | Description                             |
|------------------------|-----------------------------------------|
| VOLT_ENV               | Sets the value of Volt.env, which is used to control how various parts of the application. |
| RACK_ENV               | Also can be used to set Volt.env        |
| NO_MESSAGE_BUS         | Disable the message bus.  This will prevent updates from propagating between Volt instances, but can be useful for debugging |
| NO_FORKING             | The "Forking Server" is used in development on MRI to allow code reloading.  (It forks a child process for connections, which are killed and reforked when code changes).  Disabling forking prevents code reloading for Tasks, HttpControllers, Routes, and a few other things. |
| WEBSOCKET_PING_TIME    | When present, the websocket connection will send a ping every ```WEBSOCKET_PING_TIME``` seconds. |
| NO_WEBSOCKET_PING      | Websocket ping is only enabled by default on heroku (when the DYNO env is present), to prevent Heroku from killing idle connections. This forces a disable of the websocket ping |
| SKIP_BUNDLER_REQUIRE   | Disables auto-requiring files in the Gemfile.  This feature is considered experimental. |
| DB_NAME                | Same as Volt.config.db_name             |
| DB_HOST                | Same as Volt.config.db_host             |
| DB_PORT                | Same as Volt.config.db_port             |
| DB_DRIVER              | Same as Volt.config.db_driver           |
| DB_URI                 | Same as Volt.config.db_uri              |

