# Controllers

A controller can be any class in Volt. However, it is common to have that class inherit from ```Volt::ModelController```.  A model controller lets you specify a model that the controller works off of.  This is a common pattern in Volt.  The model for a controller can be assigned by one of the following:

1. A symbol representing the name of a provided collection model:

```ruby
    class TodosController < Volt::ModelController
      model :page

      # ...
    end
```

2. Calling `self.model=` in a method:

```ruby
    class TodosController < Volt::ModelController
      def initialize
        self.model = :page
      end
    end
```

When a model is set, any missing methods will be proxied to the model.  This lets you bind within the views without prefixing the model object every time.  It also lets you change out the current model and have the views update automatically.

In ModelControllers, the `#model` method returns the current model.

See the [provided collections](#provided-collections) section for a list of the available collection models.

You can also provide your own object to be a model.

In the example above, any methods not defined on the TodosController will fall through to the provided model.  All views in ```views/{controller_name}``` will have this controller as the target for any Ruby run in their bindings.  This means that calls on ```self``` (implicit or with ```self```.) will have the model as their target (after calling through the controller).  This lets you add methods to the controller to control how the model is handled, or provide extra methods to the views.

Volt is more similar to an MVVM architecture than an MVC architecture.  Instead of the controllers passing data off to the views, the controllers are the context for the views.  When using a ```Volt::ModelController```, the controller automatically forwards all methods it does not handle to the model.  This is convenient since you can set a model in the controller and then access its properties directly with methods in bindings.  This lets you do something like ```{{ _name }}``` instead of something like ```{{ model._name }}```

Controllers in the app/main component do not need to be namespaced, all other components should namespace controllers like so:

```ruby
    module Auth
      class LoginController < Volt::ModelController
        # ...
      end
    end
```

Here "auth" would be the component name.
