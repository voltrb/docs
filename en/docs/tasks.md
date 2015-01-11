# Tasks

Sometimes you need to explicitly execute some code on the server. Volt solves this problem through *tasks*. You can define your own tasks by inheriting from ```Volt::TaskHandler```. Ruby files in a ```tasks``` folder, which end with ```_tasks.rb```, will be required automatically.

```ruby
    # app/main/tasks/logging_tasks.rb

    class LoggingTasks < Volt::TaskHandler
      def log(message)
        puts message
      end
    end
```

Volt will automatically generate wrappers for you on the client side which will return a promise.

*Note that the classes on the server side use instance methods while the wrapper classes represent those methods as class methods*  For more information on using promises in ruby see [here](http://opalrb.org/blog/2014/05/07/promises-in-opal/).

```ruby
    class Contacts < Volt::ModelController
      def hello
        promise = LoggingTasks.log('Hello World!')
      end
    end
```

You can use the ```#then``` method of the returned promise to get the result of the call.  You can use the ```#fail``` method on the promise to get any thrown errors.

```ruby
    MathTasks.add(23, 5).then do |result|
      # result should be 28
      alert result
    end.fail do |error|
      puts "Error: #{error}"
    end
```

