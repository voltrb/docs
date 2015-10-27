# Middleware

While Volt uses websockets for database communication and tasks, it uses rack for HttpControllers and to setup the websocket connection.  You can add your own middleware.  In a component's config/initializers/boot.rb you can do the following:

```ruby
Volt.current_app.middleware.use(SomeMiddleware)
```

```Volt.current_app.middleware``` returns a ```Volt::MiddlewareStack``` that behaves like a ```Rack::Builder``` instance.  It supports the following methods:

- ```use```
- ```run```

(more methods to reorder middleware coming soon)

NOTE: Currently we don't have a way to specify where in the middleware stack middleware is loaded.  (Please ping @ryanstout in gitter if you are interested in implementing this -- it should be fairly easy)
