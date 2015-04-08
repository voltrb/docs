# A Sample Todo App

Sometimes the easiest way to learn a new piece of technology is to start building.  Our first example project will be a simple todo app like the ones on [todomvc.com](http://todomvc.com/). Our app will have many simple features:

- A field where users type in a todo and press enter to add it
- A list of todos
    - A checkbox to complete the todo
    - An X button to remove the todo
- A display of the number of remaining todos
- A button to complete all tasks (that is disabled if all tasks are already complete)

If you want, you can view [this tutorial in video form](https://www.youtube.com/watch?v=Tg-EtRnMz7o) and follow along.

To start, let's generate a new app:

```bash
gem install volt
volt new todo_example
cd todo_example
```

You'll notice that Volt created a ```todo_example``` folder and filled it with the scaffolding for a new Volt project, along with other common things like a Gemfile and sensible .gitignore. Volt apps are built as nested components, and your app starts with a component called `main`, which has a controller and some views.

To run the template server:

```bash
bundle exec volt server
```

When you save changes to a file, volt will automatically reload the file and push the changes to anyone viewing your page. Let's create a new page while leaving the server running.

First, create a new file, `app/main/views/main/todos.html` and give it some basic content:

```html
<:Title>
  Todos

<:Body>
  <h1>Todo List</h1>
```

And then add a `/todos` link to the navbar, which is rendered from `app/main/views/main/main.html`:

```html
...
<:Body>
  <div class="container">
    <div class="header">
      <ul class="nav nav-pills pull-right">
        <:nav href="/" text="Home" />
        <:nav href="/todos" text="Todos" /> <!-- New link -->
        <:nav href="/about" text="About" />
      </ul>
...
```

And also add a route for todos in `app/main/config/routes.rb`:
```ruby
get '/about', _action: 'about'
get '/todos', _action: 'todos' # New route
...
```

Once all these changes are saved, you will be able to navigate to the page we created for the Todo List.

Next, we want to add a way for users to add a todo to the list with a form, so we'll start by adding to the body of `todos.html`:

```html
...
<:Body>
  <h1>Todo List</h1>

  <form e-submit="add_todo" role="form">
    <div class="form-group">
      <label>Todo</label>
      <input class="form-control" type="text" value="{{ page._new_todo  }}" />
    </div>
  </form>
```

Anything in `{{ }}` is executed as Ruby code, both on the client and the server, so we are binding the value of the form to a member of the `page` collection. In Volt, there are a number of different collections, `page` is just a temporary collection, and will be lost if you navigate away or refresh. Any value that gets bound in the view will be automatically updated in all places, so `page._new_todo` is accessible from other parts of your code. We'll take advantage of this by adding a method to `app/main/controllers/main_controller.rb`:

```ruby
...
def add_todo
  page._todos << { name: page._new_todo }
  page._new_todo = ''
end
...
```

This method will append a hash to `page._todos` with the value of `page._new_todo` and clear out `page._new_todo`. To be able to see the `page._todos` collection, we'll add a table to our page:

```html
...
<:Body>
  <h1>Todo List</h1>

  <table class="todo-table">
    {{ page._todos.each do |todo| }}
      <tr>
        <td>{{ todo._name }}</td>
      </tr>
    {{ end }}
  </table>
...
```

Now, once everything is saved and reloads, any time you submit by hitting enter, it'll add to the list and clear out the form. Volt is reactive and intelligent, so any time the list is updated, only the new elements will be drawn; it won't redraw the entire list.

