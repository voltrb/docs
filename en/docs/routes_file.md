## Routes file

Routes are specified on a per-component basis in the config/routes.rb file.  Routes simply map from URL to params.

```ruby
    get "/todos", {_view: 'todos'}
```

Routes take two arguments; a path, and a params hash.  When a new URL is loaded and the path is matched on a route, the params will be set to the params provided for that route.  The specified params hash acts as a constraint.  An empty hash will match any url.  Any params that are not matched will be placed in the query parameters.

When the params are changed, the URL will be set to the path for the route whose params hash matches.

Route paths can also contain variables similar to bindings:

```ruby
    get "/todos/{{ _index }}", _view: 'todos'
```

In the case above, if any URL matches /todos/*, (where * is anything but a slash), it will be the active route. ```params._view``` would be set to 'todos', and ```params._index``` would be set to the value in the path.

If ```params._view``` were 'todos' and ```params._index``` were not nil, the route would be matched.

Routes are matched top to bottom in a routes file.
