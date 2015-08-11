# Puede usar jquery? (u otra librería de javascript para manipular el dom?)

Si! Por el momento Volt incluye jQuery, aunque este será removido en futuras versiones. (De todas maneras podras añadirlo tu mismo). Existen dos formas en las cuales puedes usar jQuery:

1. Para hacer llamadas JS desde los controladores de Volt (desde Opal)
2. Usando callbacks para enlazar el dom cuando sea necesario

### Llamando JS desde Volt

NOTA: Esta parte de la documentación son para las versiones 0.8.27.beta3 en adelante

Primero hablemos acerca de como llamar código JS desde Volt (por medio de Opal).Puedes revisar la documentación de Opal [aquí](http://opalrb.org/docs/compiled_ruby/).  También puedes usar código JavaScript directamente usando backticks (``` ` ```).  Si quieres que un método de controlador corra en el servidor y en el cliente al mismo tiempo, debes tener la posibilidad de correrlo solo si estás dentro de opal , esto puedes lograrlo de la siguiente manera:

```ruby
class PostController < Volt::ModelController
  def show_rendered
    if RUBY_PLATFORM == 'opal'
      # run some JS code
      `$('.post').setupCodeHighlighting()`
    end
  end
end
```

## Usando acciones

Volt provee callbacks dentro del ciclo de vida del renderizado de la vista.  Mira la sección [Callbacks y Acciones](../docs/callbacks_and_actions.html) para mayor información. Cuando manejes tus propios bindings, tienes que definirlos después de que la vista ha sido cargada y quitarlos después de que la vista a sido removida.

```ruby
class Post < Volt::ModelController
    def show_ready
        # example setup JS
        `$('.post').setupCodeHighlighting();`
    end

    def before_show_remove
        # example teardown JS
        `$('.post').cleanupCodeHighlighting()`
    end
end
```

## Obteniendo los nodos DOM de la vista

A menudo tus vistas se cargarán múltiples veces en una página. En estos casos querrás saber que nodos dom tiene la vista de un controlador específico. Por ahora Volt no permite crear id's con bindings en los mismos, pero por medio de ```ModelController``` podemos tener acceso a los nodos.

```
class Post < Volt::ModelController
    def show
      self.container # returns the container node
      self.dom_nodes # returns a range of the nodes
    end
end
```

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
      `$(post).setupCodeHighlighting()`
    end
end
```

En Opal, las variables locales se compilan a variables locales de javascript, por lo que podemos asignar a ```post``` y luego llamar al ```#container```. Dentro de nuestro JS tenemos acceso a la variable ```post```. Podemos pasar el contenedor a jQuery y llamar a nuestro método sobre el mismo.
