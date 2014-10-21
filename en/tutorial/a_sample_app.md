# A Sample App

Sometimes easiest way to learn a new piece of technology is to start building.  Our first example project will be a simple todo app like the ones on [todomvc.com](http://todomvc.com/)  Our app will have many simple features:

--TODO: Add screenshot --

- A field where users type in a todo and press enter to add.
- A list of todos
    - A checkbox to complete the todo
    - An x button to remove the todo
- The number of remaining todos
- A button to complete all tasks (that is disabled if all tasks are already complete)

To start lets generate a new app:

```
gem install volt
volt new todo_example
cd todo_example
```

You'll notice that volt created a todo_example folder and
