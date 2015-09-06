# Bindings de Eventos

En las vistas se puedes enlazar eventos DOM y llamarlos en el controlador.  Simplemente añade un atributo como e-{eventname}:

```html
<button e-click="alert">Alert Me</button>
```

El código anterior llamará una método de alerta en el controlador cuando se haga click en el botón. Volt usa jQuery por debajo, se pueden usar todos los métodos disponibles en jQuery. Múltiples eventos pueden estar atados a un solo tag.

```html
<button e-click="alert" e-mousedown="alert_pressed_down">Alert Me</button>
```

También puedes usar eventos de objeto jQuery, los cuales son creados cuando un evento ocurre pasando la variable local ```event``` dentro del controlador.

```html
<button e-click="alert(event)">Alert Me</button>
```

Dentro del controlador puedes acceder al evento de objeto jQuery de la siguiente manera:

```ruby
module Main
  class MainController < Volt::ModelController
    def alert(event)
      event.js_event # the jQuery event
    end
  end
end
```

### .js_event

Retorna el evento objeto de jQuery directamente. Al ser estos objetos JavaScript nativos y no objetos de Opal tendrás que usar backticks o Native para utilizarlos.

### .key_code

Retorna un entero para la tecla que ha sido presionada

### .stop!

Llama al método stopPropagation() en el evento jQuery

### .prevent_default!

Llama al método preventDefault() en el evento jQuery

### .target

Retorna el nodo del DOM target.
