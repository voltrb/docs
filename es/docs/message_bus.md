# Bus de Mensajes

Volt incluye una interfaz para el bus mensajes, el cual provee una interfase para la publicación/subscripción entre todas las instancias de volt (servidor, consola, runner, etc...) dentro de un cluster volt (cualquier instancia conectada a la misma base de datos). Volt incluye un bus de mensajes PeerToPeer , pero puedes crear o usar otro buses de mensajes.

El bus de mensajes es usado internamente en volt para agregar actualizaciones del modelo entre las instancias. Luego estas actualizaciones pueden ser enviadas a cualquier browser que se encuentre conectada a una instancia de volt.  Esto permite a volt escalar horizontalmente mientras se mantiene el soporte para realizar nuevas actualizaciones.

# Bus PeerToPeer

El bus peer to peer (el cual es usado por default) usa la base de datos para sincronizar una lista con los ips y puertos (para los servidores de sockets) que las instancias pueden configurar (Mira el archivo generado ```config/app/rb``` para mas obtener mas detalles de la configuración). Mientras el servidor pueda comunicarse con el resto a traves de la red, todo debería funcionar correctamente (En muchas situaciones de deployment, los servidores pueden comunicarse entre ellos en una una nube privada). Si los servidores solo tienen algunos puertos expuestos, puedes especificar los puertos habilitados en ```config/app.rb```

## El Bus de mensajes en el código de la Aplicación

El Bus de mensajes también puede ser usado desde tu aplicación. Este proveé un método ```suscribe``` y un método ```publish```.

## Bus de mensajes customizado

Puedes crear tu propio bus de mensajes implementando la clase ```BaseMessageBus``` en ```lib/volt/message_bus/base_message_bus.rb```.  Luego puedes configurar el nombre del bus así: ```config.message_bus.bus_name = 'name_of_class'``` , donde ```name_of_class``` en la versión (con underscores) del nombre de tu clase. Mira ```base_message_bus.rb``` para mas detalles de como implementar tu propio bus de mensajes.
