# Views

Views in Volt use a templating language similar to handlebars. They can be broken up into sections. A section header looks like the following:

```html
<:Body>
```

Section headers should start with a capital letter so as not to be confused with [controls](#controls).  Section headers do not use closing tags.  If no section header is provided, the Body section is assumed.

Sections help you split up different parts of the same content (title and body usually), but within the same file.

# Bindings

In Volt, views are written in a simple template language where ruby can be inserted anywhere between ```{{``` and ```}}```.  Volt lets you use the usual flow control statements in views (```if's```, ```elsif```, ```else```, ```each```)  You can also render other views using the ```template``` binding.

# Controller Backing

While we use the controller terminology, Volt is closer to a MVVM framework.  Any method call or instance variable lookup runs in the context of a controller.  The controller

If you have a view at ```app/home/views/index/index.html``` it will load the controller at ```app/home/controller/index_controller.rb```.

More on bindings can be found in the [source code](http://www.github.com/voltrb/volt/tree/master/lib/volt/page/bindings).
