# Ejemplo Aplicación de Tareas

A veces la mejor forma de aprender una nueva tecnología es empezando a usarla.  Nuestro primer ejemplo será una pequeña aplicación que nos permitirá crear un listado de tareas pendientes (TODOs) y al final lucirá mas o menos así [todomvc.com](http://todomvc.com/).  Nuestra aplicación tendrá las siguientes características:

- Un campo donde los usuarios escribirán una tarea y presionarán enter para
  agregarla
- Un listado de tareas
    - Un checkbox para marcar la tarea como completada
    - Un botón con una X para remover la tarea
- Un indicador con el número de tareas que nos queda por completar
- Un botón para completar todas las tareas (que estará deshabilitado si todas las tareas ya se han completado con anterioridad)

Puedes seguir el tutorial en conjunto con este [video](https://www.youtube.com/watch?v=Tg-EtRnMz7o)

El primer paso será generar una nueva aplicación por medio de los siguientes comandos:

```bash
gem install volt
volt new todo_example
cd todo_example
```

Después de correr estos comandos veremos que Volt crea un carpeta llamado ```todo_example``` y también añade archivos por default para empezar un nuevo proyecto, conjuntamente con el árchivo Gemfile para añadir nuestras librerías y un archivo .gitignore. Las aplicaciones de Volt son creadas como componentes anidados , es por eso que nuestra aplicación se crea con un componente llamado `main`, el cual contiene un controlador y varias vistas.

Para correr el servidor ejecutamos el siguiente comando:

```bash
bundle exec volt server
```

Cuando se guarda los cambios en un archivo, volt automáticamente reinicia el archivo y refresca los cambios a cualquier cliente que se encuentra visitando la página. Ahora creemos una página nueva mientras dejamos nuestro servidor corriendo.

Primero vamos a crear un archivo llamado `app/main/views/main/todos.html`, y le daremos un poco de contenido:

```html
<:Title>
  Todos

<:Body>
  <h1>Todo List</h1>
```

Y luego añadiremos un link de `/todos` dentro del navbar, el cual es cargado desde `app/main/views/main/main.html`:

```html
...
<:Body>
  <div class="container">
    <div class="header">
      <ul class="nav nav-pills pull-right">
        <:nav href="/">Home</:nav>
        <:nav href="/todos">Todos</:nav> <!-- New link -->
        <:nav href="/about">About</:nav>
      </ul>
...
```

También crearemos una ruta para la vista 'todos' dentro de `app/main/config/routes.rb`:
```ruby
client '/about', action: 'about'
client '/todos', action: 'todos' # New route
...
```

Una vez que todos los cambios han sido guardados, podremos navegar a la página creada para revisar nuestro listado de tareas (Todo List).

Ahora, necesitamos que los usuarios sean capaces de añadir una tarea a la lista por medio de un formulario, empezaremos por añadir esta lista dentro del body de `todos.html`:

```html
...
<:Body>
  <h1>Todo List</h1>

  <form e-submit="add_todo" role="form">
    <div class="form-group">
      <label>Todo</label>
      <input class="form-control" type="text" value="{{ page._new_todo }}" />
    </div>
  </form>
```

Todo lo que se encuentre entre `{{ }}` es ejecutado como código Ruby. El código en controladores y vistas es compilado a Javascript (por medio de [Opal](http://opalrb.org/) el cual corre en el navegador. A continuación enlazaremos el valor del formulario a uno de los miembros de la coleccion `page`. En Volt, existen diferentes tipos de colecciones, `page` es un tipo de coleccion temporal y sus datos se pierden cuando se abandona o se refresca la página. Cualquier valor que se enlaza en la vista sera actualizado automaticamente en todos los lugares en los que se muestra.  Aprovecheramos esta característica de Volt para añadir el siguiente método en `app/main/controllers/main_controller.rb`:

```ruby
...
def add_todo
  page._todos << { name: page._new_todo }
  page._new_todo = ''
end
...
```

Este metodo añadirá un hash a `page._todos` con el valor ingresado en `page._new_todo` y creará un valor por default (en este caso un string vacio) en `page._new_todo.

**Nota:** Nótese que en el método `add_todo` no inicializamos ningún arreglo vacio en `page._todos`. Volt se encarga de esto al inicializar automáticamente todo los atributos declarados en plural dentro de un `Volt::ArrayModel` vacio. No necesitamos inicializar atributos con anterioridad. De igual manera, cuando añadimos un hash al final de ```Volt::ArrayModel``` este automáticamente se convertirá en un modelo de Volt.

Para hacer posible la visualización de la colección `page._todos`, añadiremos una tabla a la página:

```html
...
<:Body>
  <h1>Todo List</h1>

  <table class="todo-table">
    {{ page._todos.each do |todo| }}
      <tr>
        <td>{{ todo._name }}</td>
      </tr>
    {{ end }}
  </table>
...
```

Ahora, cada vez que guardamos los cambios y reinicializamos , podremos constatar que cada vez que se añade una tarea y se la guarda (al presionar enter), esta se agrega a la lista y a su vez reinicializa el valor del formulario.  Volt es reactivo e inteligente, por lo que cada vez que se actualiza la lista, solo los nuevos elementos se actualizan; no se actualiza la lista entera.
