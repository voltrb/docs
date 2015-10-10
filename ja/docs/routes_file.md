## ルートファイル

ルートは、```config/routes.rb``` ファイルの中で、コンポーネントを基準にして指定します。ルートとは、単純に URL をパラメータにマッピングするものです。

```ruby
client "/todos", {view: 'todos'}
```

ルートはパスとパラメータの2つの引数を取ります。新しい URL が読み込まれて、そのパスがルートにマッチしたとき、パラメータはルートに与えるパラメータとして設定されます。特定のパラメータのハッシュは制約として働きます。例えば、空のハッシュであれば、どの URL にもマッチします。マッチしなかったパラメータはクエリパラメータとして設定されます。

パラメータが変更された場合には、そのパラメータのハッシュがマッチするルートにしたがって URL を設定します。

また、ルートのパスは、パラメータのコレクションマッピングされるバインディングを含むことができます:

```ruby
client "/todos/{{ index }}", view: 'todos'
```

上記の場合、/todos/* (* はスラッシュ以外のすべて) にマッチする URL はすべて有効なルートとなります。```params._view``` は「todos」に設定され、```params._index``` はパスに含まれる値として設定されます。

もし ```params._view``` が「todos」であり、かつ ```params._index``` が存在していれば、それはルートにマッチします。

ルートは、ルートファイル上で上から下に順番にマッチングされます。


### HTTPエンドポイントのためのルート

[HTTPコントローラー](http_controllers.md) によってHTTPエンドポイントを設定する場合、```get```/```post```/```put```/```patch```/```delete```キーワードによってルートを指定する必要があります。また、HTTPエンドポイントのルートには「コントローラー」と「アクション」をパラメーターとして指定する必要があります。

```ruby
get "/api/todos", controller: 'todos', action: 'index'
```

上記の場合、TodosControllerの```index```メソッドを実行します。詳しくは[HTTP コントローラー](http_controllers.md)を参照してください。

RESTfulなリソースを作成するためには、下記のルートを設定する必要があります。

```ruby
get "/api/todos", controller: 'todos', action: 'index'
post "/api/todos", controller: 'todos', action: 'create'
get "/api/todos/{{ id }}", controller: 'todos', action: 'show'
put "/api/todos/{{ id }}", controller: 'todos', action: 'update'
patch "/api/todos/{{ id }}", controller: 'todos', action: 'update'
delete "/api/todos/{{ id }}", controller: 'todos', action: 'destroy'
```

追加のパラメーターはコントローラーに渡されます。

```ruby
delete "/api/todos/{{ id }}", controller: 'todos', action: 'destroy', safe: true
```

上記では、```id```/```controller```/```action```/```safe```パラメーターのハッシュとしてコントローラーに渡されます。

「method」をHTTP GETまたはPOSTパラメーターとして指定すれば、実際のHTTPメソッドを上書きすることも可能です。
