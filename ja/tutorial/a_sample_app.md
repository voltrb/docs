# サンプルアプリケーション

新しい技術を学ぶときには、実際に作ってみることが一番の近道であることがあります。ここで最初に例とするプロジェクトは、[todomvc.com](http://todomvc.com/) にあるようなシンプルな todo アプリケーションです。このアプリケーションには、沢山のシンプルな機能を持たせます。

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
