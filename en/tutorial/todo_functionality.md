# More Todo Functionality

Sure, now we have a list, but things don't start to get interesting until you build additional functionality on top of that list.

To be able to remove items from the todo list, we'll need a method in the controller as well as a button linked to that method.
We'll define a `remove_todo` method in `app/main/controllers/main_controller.rb`:
```ruby
...
def remove_todo(todo)
  page._todos.delete(todo)
end
...
```
And in `app/main/views/main/todos.html`, add a button to the table of todos:
```html
<tr>
  <td>{{ todo._name }}</td>
  <td><button e-click="remove_todo(todo)">X</button></td>
</tr>
```

Obviously, our todo list also needs to be able to monitor which items have been completed. If we simply added a checkbox it wouldn't be too interesting, but because things are synced everywhere we can use that value in a number of ways. We're going to apply some CSS to completed items in the list.

```html
<tr>
  <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
  <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
  <td><button e-click="remove_todo(todo)">X</button></td>
</tr>
```

Here's some CSS that we'll use to make the todos prettier. In Volt, all CSS and JavaScript is included by default, so you rarely have to mess with require tags or script tags. You can just drop this into `app/main/assets/css/app.css.scss`:
```scss
.todo-table {
  width: auto;
}

.todo-table td {
  padding: 5px;
  border-top: 1px solid #EEEEEE;
}

.complete, tr.selected td.complete {
  text-decoration: line-through;
  color: #CCCCCC;
}

tr.selected td {
  background-color: #428bca;
  color: #FFFFFF;
}

textarea {
  height: 140px;
  width: 400px;
}

tr.selected td button {
  color: #000000;
}
```
Now you can see that checking and unchecking things updates the state right away.

Another feature we might want to add is the ability to select a Todo and add an extra description to it. We'll do this by adding more to our view:
```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>Todo List</h1>

      <table class="table">
        {{page. _todos.each do |todo| }}
        <!-- Use params to store the current index -->
        <tr
          e-click="params._index = index"
          class="{{ if params._index.or(0).to_i == index }}selected{{ end }}"
          >
          <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
          <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
          <td><button e-click="remove_todo(todo)">X</button></td>
        </tr>
        {{ end }}
      </table>

      <form e-submit="add_todo" role="form">
        <div class="form-group">
          <label>Todo</label>
          <input class="form-control" type="text" value="{{ page._new_todo }}" />
        </div>
      </form>
    </div>

    <!-- Display extra info -->
    <div class = "col-md-8">
      {{ if current_todo }}
      <h2>{{ current_todo._name }}</h2>

      <textarea>{{ current_todo.description }}</textarea>
      {{ end }}
    </div>
  </div>
```

The new stuff in our table makes it so that any time you click on a todo it sets the index in Volt's params collection, which equates to the URL params which are automatically updated.
Because values in the params collection could be unassigned, we use `#or` to provide a default value, and then apply some extra CSS to the selected todo.

The new section at the bottom says that if there is a `current_todo` we want to display some extra details about it. For this to work, we're going to need another method in our controller:
```ruby
...
def current_todo
  page._todos[params._index.or(0).to_i]
end
...
```
Now when you click on a todo the notes section of the page will update automatically.

Controllers in Volt inherit from `ModelController` which means you can assign a model to your controller and any missing methods on the controller get passed to the model. We're going to back up all of our todos to a database by importing a model:
```ruby
class MainController < Volt::ModelController
  model :store

...
```
Now we can replace all references to `page._todos` with `_todos` (in both the controller and the view) and our todos will persist to the database. Volt will now automatically sync these values to any open clients; try opening your Todos page in a few different windows and watch the changes be pushed from the server to each of the clients.

(Note: for this to work, you will need Mongo running for your server to store things in.)

From here it's simple to add a couple more features to our list:

```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>{{ _todos.size }} Todo List</h1>
...
```
This will show the number of current todos items, and wil update automatically.


If we want to manage multiple todos at once, we can take advantage of the fact that Volt collections support the methods of normal ruby collections.
```ruby
...
def check_all
  _todos.each { |todo| todo._completed = true }
end

def completed
  _todos.count { |t| t._completed }
end

def incomplete
  _todos.size - _completed
end

def percent_complete
  return ((completed / _todos.size.to_f) * 100.0).round
end
...
```
Now we can add a button that checks all items and once and a progress bar which will show how many of the items we've done so far.
```html
...
<h1>{{ _todos.size }} Todo List</h1>

<button e-click="check_all">Check All ({{ incomplete }})</button>

<div class="progress">
  <div class="progress-bar" role="progressbar" style="width: {{ percent_complete }}%;" >
    {{ percent_complete }}%
  </div>
</div>
...
```

As you can see, Volt makes it possible to do interactive things like this without writing a lot of code, and the syncing properties make it really natural to create realtime web apps.
