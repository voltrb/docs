## Reactive Accessors

The default ```Volt::ModelController``` proxies any missing methods to its model.  Sometimes you need to store additional data reactively in the controller outside of the model.  (Though often you may want to consider making another controller).  In this case, you can add a ```reactive_accessor```.  These behave just like ```attr_accessor``` except that the values assigned and returned are tracked reactively.

```ruby
module Main
  class Contacts < Volt::ModelController
    reactive_accessor :query
  end
end
```

Now, from the view, we can bind to ```query``` while also changing in and out the model. When ```query``` is accessed it tracks that it was accessed and will rerun any Computations when it changes.

Modified at {{ file.mtime }}
