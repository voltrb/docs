# Middleware

While Volt uses websockets for database communication and tasks, it uses rack for HttpController's and to setup the websocket connection.  You can add your own middleware.  In a component's config/initializers/boot.rb you can do the following:

```ruby
Volt.current_app.middleware.use(SomeMiddleware)
```

```Volt.current_app.middleware``` returns a ```Volt::MiddlewareStack``` that behaves like a ```Rack::Builder``` instance.  It supports the following methods:

- ```use```
- ```run```

(more methods to reorder middleware coming soon)

Modified at {{ file.mtime }}
