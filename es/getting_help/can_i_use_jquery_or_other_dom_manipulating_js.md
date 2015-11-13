# Puede usar jquery? (u otra librería de javascript para manipular el dom?)

Si! Por el momento Volt incluye jQuery, aunque este será removido en futuras versiones. (De todas maneras podrás añadirlo tu mismo). Existen dos formas en las cuales puedes usar jQuery:

1. Para hacer llamadas JS desde los controladores de Volt (desde Opal)
2. Usando callbacks para enlazar el dom cuando sea necesario

### Accediendo al DOM

Cuando se llama a una acción de controlador, el dom se cargará antes que la acción. Volt llamara a [varios callbacks]
(../docs/callbacks_and_actions/html) antes y después de iniciar la acción. Para manipular el dom creado en la acción podemos
usar el callback ```_ready```.

Cuando volt carga una vista, el resultado generalmente contempla una cantidad de nodos dom (no uno solo). Volt nos permite
acceder desde el callback (eg ```index_ready```) de tres maneras:

- self.dom_nodes
- self.first_element
- self.container

### dom_nodes

`dom_nodes` retorna un [Rango](https://developer.mozilla.org/en-US/docs/Web/API/Range) el cual contiene *todos* los nodos
que han sido creados. Estos pueden incluir espacios en blanco y por lo general son difíciles de usar.

### first_element

`first_element` retorna el primero [Elemento](https://developer.mozilla.org/en-US/docs/Web/API/Element) (aka Nodo de Dom) y
generalmente es lo que necesitamos. Eg si tienes vistas con un solo elemento un root (como por ejemplo un div)
first_element retornara ese div, ignorando cualquier whitespace antes de este. Incluso si no es el elemento que
estabas buscando, puede realizar un query sobre este para encontrar lo que necesitas.

``` `$(#{first_element}).find('.tab-header')` ```

En el ejemplo anterior, podemos llamar al método jquery $(..) dentro de los backticks, luego llamar al método
```first_elemnt``` de volt usando #{} (volviendo al código ruby). Esto nos devuelve un nodo jQuery el cual
representa a la vista (asumiendo que tenemos un único nodo root en nuestra vista). Luego podemos usar
```.find``` para buscar el nodo que buscamos.

### container

`container` retornará el ['common ancestor'](https://developer.mozilla.org/en-US/docs/Web/API/Range/commonAncestorContainer)
de los `don_nodes`, en otras palabras el padre de `first_element`. Esto puede ser util si tienes múltiples nodos root en
una vista. Por ejemplo, si tienes el siguiente código en una seccion de vista:

```html
<td>{{ name }}</td>
<td>{{ address }}</td>
```

En el ejemplo anterior, la vista tiene dos nodos root (los td's), por lo que first_element retornara el primer td. Usando
```container``` puedes obtener el nodo padre de los 2 elementos td.

Todas estas tres funciones ruby retornan objetos javascript, por lo que no podrás usar ruby directamente en estas. Puedes usar
backticks o el modulo `Native` de Opal (descritos a continuación).

Claro que tambien usar jQuery para buscar elementos en el DOM con su `id` especifico, pero por lo general esto puede
resultar mucho mas difícil.

### Llamando JS desde Volt

Primero hablemos acerca de como llamar código JS desde Volt (por medio de Opal).Puedes revisar la documentación de Opal [aquí](http://opalrb.org/docs/compiled_ruby/).  También puedes usar código JavaScript directamente usando backticks (``` ` ```).  Si quieres que un método de controlador corra en el servidor y en el cliente al mismo tiempo, debes tener la posibilidad de correrlo solo si estás dentro de opal , esto puedes lograrlo de la siguiente manera:

```ruby
class PostController < Volt::ModelController
  def show_ready
    if RUBY_PLATFORM == 'opal'
      # run some JS code
      first = first_element
      `$(first).find(".some_class")`
    end
  end
end
```

El código anterior hace uso de jQuery para crear un wrap sobre el elemento y encontrar un elemento por medio de su clase.
Notese como el código javascript dentro de los backticks obtiene acceso primero a la variable local `first`, pero no puede
acceder directamente a la funcion `first_element`

Si queremos usar ruby en lugar de javascript podemos hacerlo usando el modulo [Native](http://dev.mikamai.com/post/79398725537/using-native-javascript-objects-from-opal)
para los cuales tenemos ejemplos a continuacion.

## Usando acciones

Volt provee callbacks dentro del ciclo de vida del renderizado de la vista.  Mira la sección [Callbacks y Acciones](../docs/callbacks_and_actions.html) para mayor información. Cuando manejes tus propios bindings, tienes que definirlos después de que la vista ha sido cargada y quitarlos después de que la vista a sido removida.

```ruby
class Post < Volt::ModelController
    def show_ready
        # example setup JS
        first = first_element
        `first.setupCodeHighlighting();`
    end

    def before_show_remove
        # example teardown JS
        first = first_element
        `first.cleanupCodeHighlighting()`
    end
end
```

## Obteniendo los nodos DOM de la vista

Las vistas en Volt pueden tener múltiples nodos a nivel de root, permitiendo algo como lo siguiente:

##### main.html

```html
<ul>
    {{ posts.each do |post| }}
        <:post model="{{ post }}" />
    {{ end }}
</ul>
```

#### post.html

```html
<li>{{ post._title }}</li>
<li>{{ post._date }}</li>
```

Por el hecho de que las vistas no tienen un único nodo root, ```#dom_nodes``` retorna un rango en JavaScript en el cual se pueden hacer consultas. Si quieres obtener el nodo root común (como el ejemplo siguiente), puedes llamar a este id obtenerlo: ```#container```

## Ejemplo Usando Container

```ruby
class Post < Volt::ModelController
    def show
      post = self.container
      `post.setupCodeHighlighting()`
    end
end
```

En Opal, las variables locales se compilan a variables locales de javascript, por lo que podemos asignar a ```post``` y luego llamar al ```#container```. Dentro de nuestro JS tenemos acceso a la variable ```post```. Podemos pasar el contenedor a jQuery y llamar a nuestro método sobre el mismo.

### Usando Native para crear wraps sobre objetos javascript

Para usar Native, primero debemos requerirlo en el controlador:

```ruby
if RUBY_PLATFORM == 'opal'
  require "native"
end
```

Ahora el controlador podra usar solo código ruby:

```ruby
class PostController < Volt::ModelController
   def show_ready
       setupCodeHighlighting( Native(self.container) )
   end
end
```

En este caso el método ruby ``` setupCodeHighlightning``` recibe el objeto [Element](http://www.w3schools.com/jsref/dom_obj_all.asp). Luego se puede llamar sus propiedades js como métodos ruby.
