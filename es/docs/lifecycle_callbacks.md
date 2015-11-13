## Callbacks del ciclo de vida

Actualmente, volt soporta callbacks para los siguientes eventos (del lado del servidor):

### client_connect

Este evento se activa cuando un cliente activa una sesión en nuestra aplicación Volt. Un ejemplo de como conectar este evento puede
lucir de la siguiente manera:

```ruby
Volt.current_app.on("client_connect") do
    # do something
end
```

### client_disconnect

Este evento se activa cuando un cliente termina una sesión de Volt en nuestra aplicación. Un ejemplo de como conectar este evento puede
lucir de la siguiente manera:

```ruby
Volt.current_app.on("client_disconnect") do
    # do something
end
```

### user_connect

Este evento se activa cuando un usuario se loggea o inicia una sesión en una aplicación Volt (con una sesión de cookie válida). Un ejemplo de
como conectar este evento puede lucir de la siguiente manera:

```ruby
Volt.current_app.on("user_connect") do |user_id|
    user = store.users.where(id: user_id).first.sync
    user._presence = "online"
    user._session_count += 1
    user._last_login = Time.now
end
```

### user_disconnect
Este evento se activa cuando un usuario se deslogea, cierra la ventana del browser o navega fuera de la aplicación. Un ejemplo de
como conectar este evento puede lucir de la siguiente manera:

```ruby
Volt.current_app.on("user_disconnect") do |user_id|
    user = store.users.where(id: user_id).first
    user._presence = "offline"
end
```

## Custom Events
Volt también soporta eventos customizados del lado del servidor. Esto nos permite exponer hooks fácilmente para gemas de componente,
por ejemplo. Cuando quieras lanzar un callback, puedes usar el siguiente código:

```ruby
Volt.current_app.trigger!("custom_event_name", *args)
```

Un usuario de tu componente puede luego enlazar este evento de la siguiente manera:

```ruby
Volt.current_app.on("custom_event_name") do |*args|
    # do something with *args
end
```
Los eventos no necesitan tomar ningún argumento:

```ruby
Volt.current_app.trigger!("custom_event_name")

Volt.current_app.on("custom_event_name") do
    # do something
end
```
