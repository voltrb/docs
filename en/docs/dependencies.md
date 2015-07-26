# Dependencies

You can also use [tags](#tags) from one component in another.  To do this, you must require the source component from the component you wish to use them in.  This can be done in the ```config/dependencies.rb``` file.  Just put

```ruby
component 'component_name'
```

in the file.

Dependencies act just like ```require``` in ruby, but for whole components.

Sometimes you may need to include an externally hosted JS file from a component.  To do this, simply do the following in the dependencies.rb file:

```ruby
javascript_file 'http://code.jquery.com/jquery-2.0.3.min.js'
css_file '//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css'
```

Note, however, that jquery and bootstrap are currently both included by default.  Dependencies included with ```javascript_file``` and ```css_file``` will be mixed in with your component assets at the correct locations according to the order that they occur in the dependencies.rb files.

Modified at {{ file.mtime }}
