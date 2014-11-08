# Todo に機能を追加しよう

これで Todo のリストが完成しましたが、これだけでは面白くありません。Todo にもっと機能を追加しましょう。

Todo リストから項目を削除できるようにするために、コントローラーにメソッドを追加し、同時にそのメソッドに紐付いたボタンを追加しましょう。`app/main/controllers/main_controller.rb` に `remove_todo` を定義します:

```ruby
...
def remove_todo(todo)
  page._todos.delete(todo)
end
...
```

次に、`app/main/views/main/todos.html` を編集し、Todo テーブルにボタンを追加しましょう:
```html
<tr>
  <td>{{ todo._name }}</td>
  <td><button e-click="remove_todo(todo)">X</button></td>
</tr>
...
```

まだ足りない機能がありますね。Todo リスト上で、完了している項目を確認できるようにする必要があります。しかし、単純にチェックボックスを追加するだけでは面白くありません。データはすべての場所で同期されているので、値を様々な方法で利用することができます。ここでは、リスト上で完了している項目に対して CSS を適用してみましょう。

```html
...
<tr>
  <td><input type="checkbox" checked="{{ todo._completed }}" /></td>
  <td class="{{ if todo._completed }}complete{{ end }}">{{ todo._name }}</td>
  <td><button e-click="remove_todo(todo)">X</button></td>
</tr>
...
```

適用する CSS はこちらです。これで Todo をよりいい感じに表示することができるでしょう。Volt は、デフォルトですべての CSS と JavaScript をインクルードするようになっていますので、たくさんの require タグや script タグに悩まされることはほとんどありません。以下を `app/main/assets/css/app.css.scss` に記載してください:

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

これで、チェックボックスの ON/OFF によって状態が即座に更新されることを確認できるようになりました。

もうひとつ機能を追加しましょう。ある Todo を選択し、その項目に対して詳細情報を追加できるようにします。ビューを以下のように編集してください。

```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>Todo List</h1>

      <table class="table">
        {{page._todos.each do |todo| }}
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

      <textarea>{{ current_todo._description }}</textarea>
      {{ end }}
    </div>
  </div>
...
```

テーブルに追加したのは、Todo 項目をクリックしたときに Volt の params コレクションにインデックスを設定するためのものです。そして、それは自動的に更新される URL パラメータと等しくなります。params コレクションに格納される値は割り当てられていない可能性もあるので、`#or` メソッドを使ってデフォルト値を設定した上で、選択された Todo 項目に対して追加の CSS を適用しています。

また、一番最後の部分に新しいセクションを追加していますが、これは詳細情報を表示させたい現在の Todo (`current_todo`) があるかどうかを判定するためのものです。ただし、これだけではまだこの機能は動作しません。合わせて、コントローラーに以下のメソッドを追加してください:

```ruby
...
def current_todo
  page._todos[params._index.or(0).to_i]
end
...
```

これで、Todo 項目をクリックすると、それに応じた詳細情報が表示され、編集することが可能になります。

Volt ではコントローラーは `ModelController` を継承しています。このことは、コントローラーにモデルを割り当てることが可能で、そして、コントローラーに存在しないメソッドの呼び出しはモデルに受け渡されることを意味しています。これから、モデルをインポートして、Todo のデータをデータベースに保存します:

```ruby
class MainController < Volt::ModelController
  model :store

...
```

ここまで書いてきた `page._todos` は、ここからは `_todos` に置き換えることができます (コントローラーとビューのどちらも置き換えてください)。これで、Todo のデータはデータベースに永続化されます。Volt は、すべての接続中のクライアントへ自動的に同期を行います。それを確認するために、いくつかの別のウィンドウで Todo ページを開いてみてください。それぞれのクライアントに対して、サーバーから更新がプッシュされることが確認できるでしょう。

(注意: この機能はデータを保存する必要があるため、サーバー上で Mongo が起動している必要があります。)

これから、Todo リストにあといくつかの機能を追加していきます。

```html
...
<:Body>
  <div class = "row">
    <div class = "col-md-4">

      <h1>{{ _todos.size }} Todo List</h1>
...
```

これは現在の Todo 項目の数を表示する機能です。数は自動的に更新されます。



複数の Todo 項目を同時に扱いたい場合には、Volt コレクションが、通常の Ruby のコレクションと同様のメソッドをサポートしていることを利用することができます。
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

ここまでできれば、あとは、すべての項目を一度にチェックするボタンと、完了している Todo 項目の数を表示するプログレスバーを追加するだけです。
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

これまで見てきたように、Volt を使うと、大量のコードを書かなくても、こうしたインタラクティブな機能を実現することができます。そして、同期の仕組みによって、リアルタイム性を持った Web アプリケーションの開発を自然に行うことが可能になります。
