# Event Bindings

In Volt views, you can bind DOM events so they call methods on the controller.  Simply add an attribute named  e-{eventname}:

```html
<button e-click="alert">Alert Me</button>
```

The example above would call the alert method on the controller when the button was clicked.  Volt uses jQuery under the hood, so any jQuery event is supported.  Multiple events can be bound to a single tag.

```html
<button e-click="alert" e-mousedown="alert_pressed_down">Alert Me</button>
```

You can also pass the jQuery event object that is created when the event happens by passing the ```event``` local variable into the controller.

```html
<button e-click="alert(event)">Alert Me</button>
```

In the controller you can get access to the jQuery event object like so:

```ruby
module Main
  class MainController < Volt::ModelController
    def alert(event)
      event.js_event # the jQuery event
    end
  end
end
```

The event object will be an instance of Volt::JSEvent.  It has the following methods:

### .js_event

Returns the jquery event object directly.  Since this is a JavaScript object and not an Opal object, you will need to use backticks or Native to work with it.

### .key_code

Returns an int for the key that was pressed

### .stop!

Calls stopPropagation() on the jQuery event.

### .prevent_default!

Calls preventDefault() on the jQuery event.

### .target

Returns the target DOM node.

Modified at {{ file.mtime }}
