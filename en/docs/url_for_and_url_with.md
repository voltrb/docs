# url_for and url_with

If you need to generate urls using the routes, you can call ```url_for``` or ```url_with```

## url_for

```url_for``` takes a hash of params and returns a url based on the routes (and passed in params.)

Below is an example of doing a link to change ```?page=``` on the query string.  This example assumes routes for a todos controller.

```ruby
url_for(controller: 'todos', page: 5)
# => 'http://localhost:3000/todos?page=5'
```

## url_with

```url_with``` is like ```url_for```, but merges in the current params.  In the example below, assume params is ```{controller: 'todos'}```

```ruby
url_with(page: 5)
# => 'http://localhost:3000/todos?page=5'
```

Because url_for is a controller method, it can also be accessed in views.

```html
<a href="{{ url_with(page: 5) }}">page 5</a>
```

You can see more on `url_for` and `url_with` in the source code files:

[1](https://github.com/voltrb/volt/blob/master/lib/volt/controllers/model_controller.rb),

[2](https://github.com/voltrb/volt/blob/master/lib/volt/models/url.rb)
