# Before/After Filters

Often in controllers, during rendering, there is code you want to run before or after your main action runs.  Volt provides a ```before_action``` and ```after_action``` methods on the class that you can use to setup a "before action" or "after action".  You can setup actions like below:

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :english_only

    # require login is a method in Volt::ModelController
    before_action :require_login, only: :about

    def index
      # Setup index...
    end

    def about
      # Setup about...
    end

    # Redirect somewhere if they aren't in an english locale
    # (just as an example)
    def english_only
      if `navigator.language` != 'en-US'
        redirect_to '/translations'
        stop_chain # see below
      end
    end
  end
end
```

Actions can also take a block instead of a symbol for the method name.

## only certain actions

You can limit which actions a filter runs on by passing ```only: :some_action``` as an argument.  ```only``` can be set to either a symbol or an array of symbols.

# stop_chain

It is common to redirect from inside of a before filter.  If you no longer wish to continue with the rendering, you can call ```stop_chain``` in an action and the rendering will stop.

```stop_chain``` raises an exception that will be caught by the filter runner, so no code after ```stop_chain``` will be run.
