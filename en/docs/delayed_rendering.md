# Delayed Rendering

If ```self.model = ...``` is called and the model is set to a Promise, the controller will wait until the Promsie resolves before is is rendered.  Volt::ModelControllers have a ```loaded?``` method, which is checked by views when rendering.  The views reactively wait until ```loaded?``` returns true before rendering.  This is useful because you don't need to check if the model is loaded, if you assign the model to a Promise, you can assume it is ready before the view starts rendering

For example, if you did:

```ruby
module Main
  class MainController < Volt::ModelController
    def index
      self.model = store.posts.first
    end
  end
end
```

In the above example, when a view binding (or tag) started to render index.html, it would create a controller instance, then it would call ```#index```  Next the view binding would wait until the Promise resolved before rendering the index.html file.  After that it would call ```#index_ready```.  This makes it simple to wait on data before rendering.
