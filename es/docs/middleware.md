# Middleware

Aunque Volt usa websockets para comunicarse con la base y para tasks, este también usa rack para los HttpControllers y para configurar la conección de websocket.  Puedes añadir tu propio middleware si así lo deseas . En el archivo config/initializers/boot.rb del componente puedes hacer lo siguiente:

```ruby
Volt.current_app.middleware.use(SomeMiddleware)
```

```Volt.current_app.middleware``` retorna un ```Volt::MiddlewareStack``` que se comporta como una instancia ```Rack::Builder```. Este soporta los siguientes métodos:

- ```use```
- ```run```

(métodos para reorganizar el middleware se agregarán muy pronto)
