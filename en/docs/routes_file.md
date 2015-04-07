## Routes file

Routes are specified on a per-component basis in the ```config/routes.rb``` file.  Routes simply map from URL to params.

```ruby
    client "/todos", {view: 'todos'}
```

Routes take two arguments: a path and a params hash.  When a new URL is loaded and the path is matched on a route, the params will be set to the params provided for that route.  The specified params hash acts as a constraint.  For example, an empty hash will match any url.  Any params that are not matched will be placed in the query parameters.

When the params are changed, the URL will be set to the path for the route whose params hash matches.

Route paths can also contain variables similar to bindings:

```ruby
    client "/todos/{{ index }}", view: 'todos'
```

In the case above, if any URL matches /todos/*, (where * is anything but a slash), it will be the active route. In this case, ```params.view``` would be set to 'todos', and ```params.index``` would be set to the incoming value in the path.

If ```params.view``` were 'todos' and ```params.index``` were present, the route would be matched.

Routes are matched from top to bottom in a routes file.


### Routes for HTTP endpoints

For setting up HTTP endpoints via the [HTTP Controllers](http_controllers.md) you need to specify routes with the ```get```, ```post```, ```put```, ```patch``` or ```delete``` keywords. Routes for HTTP endpoints require you to set the ```controller``` and ```action``` as params on the route.

```ruby
	get "/api/todos", controller: 'todos', action: 'index'
```

will call the ```index``` method on the TodosController. See [HTTP Controllers](http_controllers.md) fo more details.

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
will make ```id```, ```controller```, ```action``` and ```safe``` availabe to the controller via the params hash.

You can overwrite the actual HTTP method by providing setting "method" via the HTTP GET or POST parameters.