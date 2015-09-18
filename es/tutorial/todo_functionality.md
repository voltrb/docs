# Mas funcionalidad en la aplicación de Tareas

Finalmente tenemos nuestra lista de tareas!, pero no va a ser muy interesante hasta que no le agreguemos mayor funcionalidad.

Dentro de la vista `app/main/views/main/todos.html` añade el siguiente botón en la tabla de la lista de tareas:

```html
...
<tr>
  <td>{{ todo._name }}</td>
  <td><button e-click="todo.destroy">X</button></td>
</tr>
...
```

Obviamente, nuestra lista de tareas necesita ser capás de saber que tareas han sido completadas. No sería muy interesante si simplemente añadimos un checkbox, pero gracias al hecho de que los datos siempre están sincronizados podemos utilizar este valor de diversas maneras. Vamos a aplicar una clase de CSS a aquellas tareas que han sido completadas en la lista.

```html
...
<tr>
  <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
  <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
  <td><button e-click="todo.destroy">X</button></td>
</tr>
...
```

Puedes usar el siguiente código CSS para que tu lista se vea mejor. En Volt nuestros archivos CSS y JavaScript son incluidos automáticamente, por lo que en muy pocos casos tendrás que incluirlos tu mismo. Puedes copiar el siguiente código dentro de `app/main/assets/css/app.css.scss`:

```scss
textarea {
  height: 140px;
  width: 100%;
}

.todo-table {
  width: auto;

  tr {
    &.selected td {
      background-color: #428bca;
      color: #FFFFFF;

      button {
        color: #000000;
      }
    }

    td {
      padding: 5px;
      border-top: 1px solid #EEEEEE;

      &.complete {
        text-decoration: line-through;
        color: #CCCCCC;
      }
    }
  }
}
```

Ahora nuestro atributo de clases cambiará basado en el estado del checkbox.

Otra característica que podríamos añadir es la habilidad de seleccionar una tarea y añadir información extra a la misma. En este punto deberíamos añadir estilos de bootstrap para que nuestro layout se vea mejor. Haremos esto añadiendo lo siguiente a nuestra vista:

```html
...
<:Body>
  <div class="row">
    <div class="col-md-4">

      <h1>Todo List</h1>

      <table class="todo-table">
        {{page._todos.each_with_index do |todo, index| }}
        <!-- Use params to store the current index -->
        <tr
          e-click="params._index = index"
          class="{{ if (params._index || 0).to_i == index }}selected{{ end }}"
          >
          <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
          <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
          <td><button e-click="todo.destroy">X</button></td>
        </tr>
        {{ end }}
      </table>

      <form e-submit="add_todo" role="form">
        <div class="form-group">
          <label>Todo</label>
          <input class="form-control" type="text" value="{{ page._new_todo }}" />
        </div>
      </form>
    </div>

    <!-- Display extra info -->
    <div class="col-md-8">
      {{ if current_todo }}
      <h2>{{ current_todo._name }}</h2>

      <textarea>{{ current_todo._description }}</textarea>
      {{ end }}
    </div>
  </div>
...
```

El nuevo código en nuestra tabla ahora actualizará también nuestro url, ya que enviamos el valor de nuestro index a params, los cuales son actualizados automáticamente. Ya que los valores en params necesariamente necesitan ser asignados debemos proporcionar un valor por default por medio de `||`, y luego agregamos mas estilos para las tareas seleccionadas.

La nueva sección al final mostrará mas detalles de la actual tarea por medio del método `current_todo`, el cual vamos a agregar a nuestro controller

```ruby
...
def current_todo
  page._todos[(params._index || 0).to_i]
end
...
```

Ahora, cada vez que hacemos click en una tarea el detalle de esta se actualizará en la sección de notas.

Los controladores también se encuentran dentro del namespace del componente en del que forman parte (hablaremos mas a profundidad sobre componentes). Los controladores en Volt heredan de la clase `Volt::ModelController` lo que significa que aquellos métodos que no se encuentran en el controlador pueden ser asignados a un modelo. Vamos a guardar nuestras tareas dentro de la base asignándola a un modelo:

```ruby
module Main
  class MainController < Volt::ModelController
    model :store

...
```

Ahora podemos remplazar todas las referencias a `page._todos` con `_todos` (en la vista y en el controlador) y todas nuestras tareas serán guardadas en la base. Para esto debemos tener Mongo corriendo. (Nota: Agregaremos soporte para mas bases muy pronto!)

Si nunca has usado Mongo antes, puede encontrar instrucciones para su instalación en su sitio web como [guias de instalación](http://docs.mongodb.org/manual/installation/).  Como se menciona en las instrucciones, asegúrate que el usuario sobre el que se corre Mongo tiene permisos de escritura para el directorio `/data/db`. Si quieres correr Mongo sobre el usuario con el que estas conectado por medio de `sudo` o un comando similar, asegúrate de correr `sudo chown $USER /data/db` después de haber creado el directorio.

Una ves que tengamos Mongo instalado, podremos correrlo como un proceso background, o simplemente ejecutamos `mongod` en otra terminal. Mientras estemos seguros que el proceso este corriendo y estemos usando `_todo` en la vista y en el controlador, Volt sincronizará automáticamente estos valores para cualquier cliente.

Ahora ya es mucho mas fácil agregar mas funcionalidad a nuestra lista:

```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>{{ _todos.size }} Todo List</h1>
...
```

Esto nos mostrará el numero de tareas actuales y se actualizará automáticamente.

Si queremos manejar múltiples listas al mismo tiempo, podemos aprovechar el hecho de que las colecciones en Volt soportan métodos normales para colecciones de ruby

```ruby
...
def check_all
  _todos.each { |todo| todo._completed = true }
end

def completed
  _todos.count { |t| t._completed }
end

def incomplete
  # because .size and completed both return promises, we need to
  # call .then on them to get their value.
  _todos.size.then do |size|
    completed.then do |completed|
      size - completed
    end
  end
end

def percent_complete
  _todos.size.then do |size|
    completed.then do |completed|
      (completed / size.to_f * 100).round
    end
  end
end
...
```

Ahora podemos agregar un botón para completar todos los elementos de la lista al mismo tiempo y una barra de progreso que nos mostrará cuantas de nuestras tareas hemos completado hasta ahora.

```html
...
<h1>{{ _todos.size }} Todo List</h1>

<button e-click="check_all">Check All ({{ incomplete }})</button>

<div class="progress">
  <div class="progress-bar" role="progressbar" style="width: {{ percent_complete }}%;" >
    {{ percent_complete }}%
  </div>
</div>
...
```

Como podemos ver, Volt hace posible funcionalidades interactivas como esta sin tener que escribir mucho código adicional, y las propiedades de sincronización hace muy fácil el crear aplicaciones web de tiempo real.
