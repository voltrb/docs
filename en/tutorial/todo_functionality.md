# More Todo Functionality

Sure, now we have a list, but things don't start to get interesting until you build additional functionality on top of that list.

And in `app/main/views/main/todos.html`, add a button to the table of todos:

```html
...
<tr>
  <td>{{ todo._name }}</td>
  <td><button e-click="todo.destroy">X</button></td>
</tr>
...
```

Obviously, our todo list also needs to be able to monitor which items have been completed. If we simply added a checkbox it wouldn't be too interesting, but because things are synced everywhere we can use that value in a number of ways. We're going to apply a CSS class to completed items in the list.

```html
...
<tr>
  <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
  <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
  <td><button e-click="remove_todo(todo)">X</button></td>
</tr>
...
```

Here's some CSS that we'll use to make the todos prettier. In Volt, all CSS and JavaScript is included by default, so you rarely have to mess with require tags or script tags. You can just drop this into `app/main/assets/css/app.css.scss`:

```scss
textarea {
  height: 140px;
  width: 100%;
}

.todo-table {
  width: auto;

  tr {
    &.selected td {
      background-color: #428bca;
      color: #FFFFFF;

      button {
        color: #000000;
      }
    }

    td {
      padding: 5px;
      border-top: 1px solid #EEEEEE;

      &.complete {
        text-decoration: line-through;
        color: #CCCCCC;
      }
    }
  }
}
```

Now the class changes based on the checkbox state.

Another feature we might want to add is the ability to select a todo and add an extra description to it. At this point we will also add a few grid framework (Bootstrap) placement classes to make the layout look a little nicer. We'll do this by adding more to our view:

```html
...
<:Body>
  <div class="row">
    <div class="col-md-4">

      <h1>Todo List</h1>

      <table class="todo-table">
        {{page._todos.each_with_index do |todo, index| }}
        <!-- Use params to store the current index -->
        <tr
          e-click="params._index = index"
          class="{{ if (params._index || 0).to_i == index }}selected{{ end }}"
          >
          <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
          <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
          <td><button e-click="todo.destroy">X</button></td>
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
    <div class="col-md-8">
      {{ if current_todo }}
      <h2>{{ current_todo._name }}</h2>

      <textarea>{{ current_todo._description }}</textarea>
      {{ end }}
    </div>
  </div>
...
```

The new stuff in our table makes it so that any time you click on a todo it sets the index in Volt's params collection, which equates to the URL params which are automatically updated.  Because values in the params collection could be unassigned, we use `||` to provide a default value, and then apply some extra CSS to the selected todo.

The new section at the bottom says that if there is a `current_todo`, we want to display some extra details about it. For this to work, we're going to need another method in our controller:

```ruby
...
def current_todo
  page._todos[(params._index || 0).to_i]
end
...
```

Now, when you click on a todo, the notes section of the page will update automatically.

Controllers are also contained inside of a namespace that matches their component (more on components later.)  Controllers in Volt typically inherit from `Volt::ModelController` which means you can assign a model to your controller and any missing methods on the controller get passed to the model.  We're going to back up all of our todos to a database by assigning a model:

```ruby
module Main
  class MainController < Volt::ModelController
    model :store

...
```

Now we can replace all references to `page._todos` with `_todos` (in both the controller and the view) and our todos will persist to the database. We just need to have Mongo running.  (Note: more databases coming soon!)

If you've never used Mongo before, you can find instructions for installing it on your operating system on their website, under [Installation Guides](http://docs.mongodb.org/manual/installation/). As mentioned in their instructions, be sure that the user who is going to be running Mongo has read and write permissions for the `/data/db` directory. If you'd like to run Mongo as the user that you are currently logged in as without using `sudo` or similar, be sure to run `sudo chown $USER /data/db` after you've created the directory.

Once you have Mongo installed, you can start it as either a background process, or by simply running `mongod` in a separate terminal. As long as it's running, and you are using `_todos` in the view and controller, Volt will now automatically sync these values to any open clients.

Go ahead and try opening your Todos page in a few different windows and make some changes to one of the Todo items. If you've set up Mongo correctly, you should see your changes get pushed from the server to each of the clients.

From here it's simple to add a couple more features to our list:

```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>{{ _todos.size }} Todo List</h1>
...
```

This will show the number of current todo items and will update automatically.

If we want to manage multiple todos at once, we can take advantage of the fact that Volt collections support the methods of normal Ruby collections.

```ruby
...
def check_all
  _todos.each { |todo| todo._completed = true }
end

def completed
  _todos.count { |t| t._completed }
end

def incomplete
  _todos.size - completed
end

def percent_complete
  (completed / _todos.size.to_f * 100).round
end
...
```

Now we can add a button that checks all items at once and a progress bar which will show how many of the items we've done so far.

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
