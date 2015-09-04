# Componentes por default

Volt proveé algunos componentes para construir nuestra aplicación de manera muy fácil.

## Notificaciones

Volt automáticamente agrega ```<:volt:notices />``` en nuestras vistas.  Este componente muestra notificaciones para los siguientes escenarios:

1. Mensajes flash
2. Estado de la conecciones (cuando ocurre una desconección, este muestra una alerta explicándonos el porque y el tiempo en el que se intentará una reconección)
3. Notifica reloading por cambios en el código (solo en el modo de desarrollo)

## Flash

Como parte del componente de notificaciones, explicado anteriormente, puedes agregar a este cualquier mensaje dentro de cualquier colección.

Cada colección representa un tipo de notificación flash. Por ejemplo puedes usar ```_notices``` y ```_errors``` para mostrar diferentes colores en las notificaciones.

```ruby
flash._notices << "message to flash"
```

Estos mensajes se mostrarán por 5 segundos, luego desaperecerán (de la pantalla y de la memoria).
