## Routes file

Routes are specified on a per-component basis in the ```config/routes.rb``` file.  Routes simply map from URL to params.

```ruby
client "/todos", {view: 'todos'}
```

Routes take two arguments: a path and a params hash.  When a new URL is loaded and the path is matched on a route, the params will be set to the params provided for that route.  The specified params hash acts as a constraint.  For example, an empty hash will match any url.  Any params that are not matched will be placed in the query parameters.

When the params are changed, the URL will be set to the path for the route whose params hash matches.

Route paths can also contain bindings, which map into the params collection:

```ruby
client "/todos/{{ index }}", view: 'todos'
```

In the case above, if any URL matches /todos/*, (where * is anything but a slash), it will be the active route. In this case, ```params._view``` would be set to 'todos', and ```params._index``` would be set to the incoming value in the path.

If ```params._view``` is 'todos' and ```params._index``` is present, the route will be matched.

Routes are matched from top to bottom in a routes file.

### Splat matches

You can use * as you would in a ruby splat to match the rest of the url (not just a single section):

```ruby
client "/blog/{{ *slug }}", component: 'main', controller: 'blog', action: 'show'
```

The above will match anything that starts with ```/blog/```, the rest of the url will be placed in ```params._slug```

### Routes for HTTP endpoints

For setting up HTTP endpoints via the [HTTP Controllers](http_controllers.md) you need to specify routes with the ```get```, ```post```, ```put```, ```patch``` or ```delete``` keywords. Routes for HTTP endpoints require you to set the ```controller``` and ```action``` as params on the route.

```ruby
get "/api/todos", controller: 'todos', action: 'index'
```

The above will call the ```index``` method on the TodosController. See [HTTP Controllers](http_controllers.md) for more details.

To create a RESTful resource you have to create the following routes

```ruby
get "/api/todos", controller: 'todos', action: 'index'
post "/api/todos", controller: 'todos', action: 'create'
get "/api/todos/{{ id }}", controller: 'todos', action: 'show'
put "/api/todos/{{ id }}", controller: 'todos', action: 'update'
patch "/api/todos/{{ id }}", controller: 'todos', action: 'update'
delete "/api/todos/{{ id }}", controller: 'todos', action: 'destroy'
```

All additional params are passed down to the controller.

```ruby
delete "/api/todos/{{ id }}", controller: 'todos', action: 'destroy', safe: true
```

The above will make ```id```, ```controller```, ```action``` and ```safe``` availabe to the controller via the params hash.

You can overwrite the actual HTTP method by providing setting "method" via the HTTP GET or POST parameters.
