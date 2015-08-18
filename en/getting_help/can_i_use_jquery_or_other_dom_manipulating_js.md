# Can I use jQuery (or other dom manipulating JS)

Yes!  At the moment Volt ships with jQuery, though this will be removed in a future version.  (Though you'll always be able to use Volt with jQuery)  There's two parts to using jQuery in Volt:

1. Calling JS from Volts controller's (via Opal)
2. Using action callbacks to bind to the dom at the right times.

To access the dom that volt has rendered, access has to be after the action, usually in
a ``` _ready ``` callback.
Volt provides callbacks into the rendering life-cycle of views.  See [Callbacks and Actions](../docs/callbacks_and_actions.html) for info.

## Calling JS from Volt

First let's talk about how to call JS code from Volt (via Opal).  Opal has some docs on it [here](http://opalrb.org/docs/compiled_ruby/).  Typically you can just do inline JS by using backticks (``` ` js code ` ```).
Javascript code like that has access to local ruby variables.

If you want your controller method to run both on the server and the client, you'll need to only run it if you're in opal.  This can be accomplished as follows:

```ruby
class PostController < Volt::ModelController
  def show_ready
    if RUBY_PLATFORM == 'opal'
        # run some JS code
        `$('.post').setupCodeHighlighting()`
    end
  end
end
```
This uses jQuery to access an element by known class. This can work well if you have few such cases
and can easily find the elements by jQuery queries. If on the other hand you want to access the
nodes that volt created without queries, see below.

Another, more ruby-ish, way of using JS is by using the [Native ](http://dev.mikamai.com/post/79398725537/using-native-javascript-objects-from-opal) Module, for which
there are examples below.

## Using actions

When managing your own dom bindings,
you need to set them up after the view has rendered and **remove** them before the view removes.

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

## Getting the view DOM nodes

Often your views will be rendered multiple times on a page.  In these cases you will want to know which dom node's the view for this controller has.  Currently Volt does not allow for id's with bindings in them.  (This will change in the future.)  However, Volt's ```ModelController``` provides two different ways to access the dom nodes.

```ruby
class Post < Volt::ModelController
    def show_ready
        self.container # returns the container node
        self.dom_nodes # returns a range of the nodes
    end
end
```

Both ``` self.container ``` and ``` self.dom_nodes ``` will return Javascript objects, so using them as normal ruby objects will not work. You need to use the backtick technique described above, or the Native wrapping, described below.

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
        `$(post).setupCodeHighlighting()`
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
[Element](http://www.w3schools.com/jsref/dom_obj_all.asp). You can then use ruby methods to access
the js properties.
