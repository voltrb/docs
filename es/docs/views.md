# Vistas

Las vistas en volt tienen su propio sistema de templating.  Estos pueden ser separados en secciones. El header de una sección luce de la siguiente manera:

```html
<:Body>
```

Los secciones header deben empezar con una letra mayúscula (así no los confundiremos con [tags](#tags)). Estos no tienen que ser cerrados como los tags normales. Si no se proveé con un header de sección volt asumirá que estás en la sección ```:Body```.

Las secciones nos ayudan a separar diferentes partes de un mismo contenido (usualmente el título y el body del html), pero dentro del mismo archivo

# Bindings

Las vistas usan un lenguaje sencillo de templating, donde el código ruby es insertado entre ```{{``` y ```}}```. Volt también nos permite crear un control de flujo en las vistas por medio de los statements usuales: (```if```, ```elsif```, ```else``` y ```each```). También puedes cargar otras vistas usando el binding ```view```.

# Controlador

Aunque Volt es mas un framework Modelo-Vista-VistaModelo (MVVM) que un framework MVC, hemos decidido usar la terminología MVC y el término controlador - esto solo significa que usarás el término 'Controller' en vez de 'ViewModel'.

Cualquier llamado a un método o una variable de instancia en una vista se la hará en el contexto de este controlador.

Si tienes una vista en ```app/main/views/index/index.html``` esta cargará el controlador ```app/main/controller/index_controller.rb```.
