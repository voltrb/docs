# Can I use jQuery (or other dom manipulating JS)

Yes!  At the moment Volt ships with jQuery, though this will be removed in a future version.  (Though you'll always be able to use Volt with jQuery)  There's two parts to using jQuery in Volt:

1. Calling JS from Volt's controllers (via Opal)
2. Using action callbacks to bind to the dom at the right times.

## Accessing the DOM

When a controller action is called, the dom will be rendered after that action. Volt will issue [several callbacks](../docs/callbacks_and_actions.html)
before and after the action, and to manipulate the dom that was created in the action, the ``` _ready ``` callback can be used.

When Volt renders a view, the result is usually a number of dom-nodes, not just one. Volt allows access to the dom from the callback (eg ``` index_ready ```) in three ways:

- self.dom_nodes
- self.first_element
- self.container

### dom_nodes

`dom_nodes` returns a [Range](https://developer.mozilla.org/en-US/docs/Web/API/Range) of *all* the nodes in the view. These include whitespace and can generally be somewhat tricky to work with directly.

### first_element

`first_element` gives you the first  [Element](https://developer.mozilla.org/en-US/docs/Web/API/Element) (aka Dom Node) and is often what you want.  If you have views with a single root element (say div) first_element will return that, ignoring any whitespace before it. A common pattern is to get the first element, then query for the element inside of the view with it:

``` `$(#{first_element}).find('.tab-header')` ```

In the above example, we call jQuery's $(..) inside of backticks, then call Volt's ```first_element``` using #{} (going back to ruby).  This gives a jQuery wrapped node that represents the view (assuming we have a single root node in our view).  Then we can use ```.find``` to query for the node we are looking for.

### container

`container` will give you the  [common ancestor](https://developer.mozilla.org/en-US/docs/Web/API/Range/commonAncestorContainer) of `dom_nodes`, in other words the parent of `first_element`  This can be useful if you have multiple root nodes in a view.  For example, if you had the following in a view section:

```html
<td>{{ name }}</td>
<td>{{ address }}</td>
```

In the above, the view has two root nodes (the td's), so first element will return the first ```td```.  Using ```container``` you can get back the parent node of the two ```td```'s.

All three (ruby) functions return javascript objects. As such you can not use ruby directly to use those objects, but must either use backticks or the Native module, both described below.

Off course you can also use jQuery to search the DOM for elements with specific id's or other css searches, but that is usually more cumbersome and fragile.

## Calling JS from Volt

First let's talk about how to call JS code from Volt (via Opal).  Opal has some docs on it [here](http://opalrb.org/docs/compiled_ruby/).  Typically you can just do inline JS by using backticks (``` ` js code ` ```).
Javascript code like that has access to local ruby variables.

If you want your controller method to run both on the server and the client, you'll need to only run it if you're in opal.  This can be accomplished as follows:

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
This uses jQuery to wrap the element and find an element by known class. Notice how the javascript inside the backticks has access to the local variable first, but would not know the function first_element.

Another, more ruby-ish, way of using javascript is by using the [Native ](http://dev.mikamai.com/post/79398725537/using-native-javascript-objects-from-opal) Module, for which
there are examples below.

## Using actions

When managing your own dom bindings,
you need to set them up after the view has rendered and **remove** them before the view removes.

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
These examples assume javascript setup/cleanup functions. To use ruby functions see the native approach below.

## Getting the view DOM nodes


Views in Volt can have multiple dom nodes at the root level, allowing things like the following:

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

Because views do not have a single root node, ```#dom_nodes``` returns a JS range that you can query inside of.  If you want the common root node (which may be above the nodes, as in the example above), you can call ```#container```

## Example Using Container

```ruby
class Post < Volt::ModelController
    def show_ready
        post = self.container
        `post.setupCodeHighlighting()`
    end
end
```

In opal, local variables compile down to JS local variables, so we can assign ```post``` and then call ```#container```.  Inside of our JS we have access to the ```post``` variable.  We can pass the container node to jQuery and call our method on it.

### Using Native to wrap js objects

To use Native, you first need to require it in the controller:

```ruby
if RUBY_PLATFORM == 'opal'
  require "native"
end
```

And the controller action can then use ruby only, like:

```ruby
class PostController < Volt::ModelController
  def show_ready
      setupCodeHighlighting( Native(self.container) )
  end
end
```

In that case the ruby method ``` setupCodeHighlighting ``` receives the wrapped
[Element](http://www.w3schools.com/jsref/dom_obj_all.asp). You can then use ruby methods to access the js properties.
