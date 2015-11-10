# Controladores

Un controlador puede ser cualquier clase en Volt. Pero lo común es que esta clase herede de ```Volt::ModelController```. Los controladores se encuentran dentro del mismo namespace del módulo con el nombre del componente. Este es un patrón muy común en Volt. El modelo para un controlador puede ser asignado de las siguientes maneras:

1. Mediante un símbolo que representa el nombre de una colección de modelo provista:

```ruby
module Main
  class TodosController < Volt::ModelController
    model :page
    # ...
  end
end
```

2. Llamando `self.model=` en un método:

```ruby
module Main
  class TodosController < Volt::ModelController
    def initialize
      self.model = :page
    end
  end
end
```

Una vez configurado el modelo, cualquier método que no exista en el controlador será buscado en el modelo. Esto nos permite enlazar los valores en la vista sin tener que invocarlos mediante el nombre del objeto. Tambien nos permite cambiar el modelo actual y mantenerlo actualizado automáticamente.

En los ModelControllers, el metodo '#model' retorna el modelo actual.

Mira la secciones de [colecciones](provided_collections.md) para obtener una lista de todas las colecciones disponibles.

Tambien puedes usar un objeto propio y utilizarlo como modelo.

En el ejemplo, cualquier método que no se encuentre definido en TodosController se lo llamará en el modelo provisto. Todas las vistas  dentro de la carpeta ```views.{controller_name}``` usarán este controlador para todo el código ruby entre sus bindigs. Esto significa que cuando llamemos a ```self``` (implicito o con ```self```) estaremos invocando al modelo (después de haberlo llamado a traves del controlador). Esto nos permite añadir métodos al controlador para 'controlar' como el modelo es manejado, o proveer métodos extras a las vistas

Volt es mas similar a una arquitectura MVVM que a una arquitectura MVC. Los controladores en un esquema MVVM no pasan datos a las vistas , sino que funcionan mas como el contexto de las mismas. Cuando usas un ```Volt::ModelController```, el controlador automáticamente delega los llamados a métodos que no maneja hacia el modelo. Esto es conveniente ya que puedes configurarla con un modelo y luego acceder a sus propiedades directamente con los métodos de bindings. Esto te permite hacer cosas como ```{{ _name }}``` y no tener que hacer algo como ```{{ model._name }}```
