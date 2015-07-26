# サンプル Todo アプリケーション

新しい技術を学ぶときには、実際に作ってみることが一番の近道であることがあります。ここで最初に例とするプロジェクトは、[todomvc.com](http://todomvc.com/) にあるようなシンプルな todo アプリケーションです。このアプリケーションには、沢山のシンプルな機能を持たせます。

- ユーザーが todo を入力し、enter キーを押すと登録されるフィールド
- todo のリスト
    - todo を完了するためのチェックボックス
    - todo を削除するための X ボタン
- 残っている todo の数の表示
- すべてのタスクを完了にするためのボタン (すべてのタスクがすでに完了済の場合は無効)

[チュートリアル動画 (英語)](https://www.youtube.com/watch?v=Tg-EtRnMz7o) も用意しています。

まずは新しいアプリケーションを作成しましょう:

```bash
gem install volt
volt new todo_example
cd todo_example
```

上記を実行すると、Volt は ```todo_example``` フォルダーを作成し、その中に Volt プロジェクトのための土台 (scaffold) となるファイル群を格納します。また、Gemfile や .gitignore といった一般的なファイルも同時に作成されます。Volt アプリケーションはネストされたコンポーネントから構成され、アプリケーションは `main` というコンポーネントから起動します。`main` コンポーネントは1つのコントローラーといくつかのビューを持っています。

サーバーは以下で起動します:

```bash
bundle exec volt server
```

ファイルが変更されたときには、Volt は自動的にそのファイルをリロードし、すべての開いているページに対して変更をプッシュします。サーバーが起動したままの状態で、新しいページを作成してみましょう。

まずは、`app/main/views/main/todos.html` という新規ファイルを作成し、そこに基本的なコンテンツを追加します:


```html
<:Title>
  Todos

<:Body>
  <h1>Todo List</h1>
```

そして、ナビゲーションバーに `/todos` リンクを追加します。ナビゲーションバーをレンダリングする `app/main/views/main/main.html` ファイルを編集しましょう:


```html
...
<:Body>
  <div class="container">
    <div class="header">
      <ul class="nav nav-pills pull-right">
        <:nav href="/">Home</:nav>
        <:nav href="/todos">Todos</:nav> <!-- New link -->
        <:nav href="/about">About</:nav>
      </ul>
...
```

また、`app/main/config/routes.rb` に、todos のためのルーティングを設定します:
```ruby
client '/about', action: 'about'
client '/todos', action: 'todos' # New route
...
```

ここまでの変更を保存してください。これで、Todo リストへのナビゲーションが用意できました。

次に、ユーザーが Todo をリストに追加できるようにしましょう。そのために、`todos.html` の body に追加していきます:


```html
...
<:Body>
  <h1>Todo List</h1>

  <form e-submit="add_todo" role="form">
    <div class="form-group">
      <label>Todo</label>
      <input class="form-control" type="text" value="{{ page._new_todo }}" />
    </div>
  </form>
```

`{{ }}` の中に書かれたものは、すべて Ruby コードとして実行されます。コントローラーとビューに書かれたコードは ([Opal](http://opalrb.org/) を使って) JavaScript にコンパイルされ、ブラウザ上で実行されます。上記では、フォームの value を `page` コレクションののメンバーにバインドしています。Volt には様々なコレクションがあります。この `page` というのは一時的な記憶の用途で使われるコレクションで、ページを移動したり更新したりすると消えます。ビューでバインドされていると、その値は自動的に表示されているすべての場所で更新されます。これを活用するために、`app/main/controllers/main_controller.rb` に以下のメソッドを追加しましょう:


```ruby
...
def add_todo
  page._todos << { name: page._new_todo }
  page._new_todo = ''
end
...
```

このメソッドは、`page._todos` に対して `page._new_todo` の値の Hash を追加したあとで、`page._new_todo` を空にします。

**メモ:** `add_todo` の中で、`page._todos` を空の Array で初期化する必要はありません。これは、Volt は、複数形の属性を自動的に空の `Volt::ArrayModel` に初期化するからです。したがって、事前に初期化しておく必要はありません。また、```Volt::ArrayModel``` にハッシュを追加した場合、自動的に Volt のモデルに変換されます。

`page._todos` コレクションを確認するため、ページにテーブルを追加します:

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

ここまでの内容を保存して再読込すれば、enter キーを押すことで Todo がリストに追加され、入力した内容はフォームから消える、という機能が実装されています。Volt はリアクティブで、かつ賢く動作します。リストが更新されるときには、その新しい要素の追加のみが行われ、その際に全てのリストを再描画することはありません。


で修正されましたt {{ file.mtime }}
