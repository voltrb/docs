# Store コレクション

ストアコレクションは、データベースにデータを保存するためのものです。現在サポートされているデータベースは Mongo のみです。(他のものも検討中です。おそらく次は RethinkDB と Postgres に対応するでしょう)```store``` は、サーバーからデータが帰ってくるのを待つ必要があります。したがって、```store``` に対するクエリメソッドはすべて promise を返すようになっています。もし promise について知らないのであれば、続きを読む前に [Opal の promise に関するドキュメントを一読してください](http://opalrb.org/docs/promises/)  。

Volt ではフロントエンドとバックエンドのどちらでも ```store``` にアクセスすることができます。そして、ブラウザとサーバー間でデータが自動的に同期されます。```store``` のデータに対する変更はすべて、そのデータを利用中のすべてのクライアントに対して反映されます。(ただし、後述の [buffer](#buffer) が使われている場合は除きます。)

```ruby
store._items.create({name: 'Item 1'})
# => #<Promise(70297824266280): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>

store._items[0]
# => #<Promise(70297821413860): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>
```

```create``` (もしくは```append``` や ```<<```) を ```store._items``` に対して実行すると、データストアに ```items``` テーブルが (まだ存在していなかった場合は) 作成され、モデルのドキュメントが挿入されますその際、[グローバルにユニークな](http://en.wikipedia.org/wiki/Globally_unique_identifier) ```id``` が自動的に生成されます。

## store における promise

非同期の読み込みを実現するために、store の ArrayModel に対するメソッド実行は promise を返します。そのクエリの結果を処理する場合は .then を使います。

```ruby
store._items.first.then do |item|
  # item に対する処理
end
```

ruby/opal のpromiseについては[このページを参照してください](http://opalrb.org/blog/2014/05/07/promises-in-opal/)。

## バインディングにおけるpromise

promiseはバインディングに渡され、promiseが解決されると値を更新します。これは、以下のようなことが可能であることを意味します:

```html
{{ store._items.first.then {|i| i._name } }}
```

これは最初の要素を取得し、それが解決したらその名前を返しています。これはリアクティブ性を保つためでもあります。なぜなら、もし最初の要素が変わった場合、バインディングを再度実行して再度解決するからです。

## Promise メソッド フォワーディング

上記の例をよりシンプルにするために、Volt は promise を拡張し、promise に対してのメソッドの直接実行を可能にし、promise が解決した場合にそのメソッドが解決された値に対して実行されるようにしています。したがって、意味的に以下は同じになります。

```ruby
store._items.first.then {|i| i._name }
store._items.first._name
```

## promiseの同期

もしstoreが(例えばtasksなどで)サーバー側のみである場合、promiseに対して```.sync```を実行することで、同期的に解決しその結果を返すことができます。もしpromiseが失敗した場合、```.sync```はエラーを発生させます。

```ruby
# これはサーバー、もしくはコンドール上でのみ有効です

store._items.create({name: 'Item 1'})

# .sync blocks until the items are loaded
store._items.first.sync
# => #<Volt::Model id: "3607..a0b0", name: "Item 1">

store._items.size.sync
# => 1
```

## クエリ

現在、storeはMongoDBのデータベースに永続化されます。データストアを問わないサポートを実現できるようにデータプロバイダAPIを開発中です。現在、Voltがサポートするクエリメソッドは以下の通りです。

### .where

```.where``` は引数をMongoDBに渡し、```.find``` を実行します。

### .limit

```.limit``` は必要に応じて結果の数を制限します。

### .skip

```.skip``` はどこから取得を開始するかを設定しますstore._items.skip(5).limit(10) は 5から15番目の要素を取得します。

### .order

```.order``` は引数をMongoDBに渡し、```.sort``` を呼び出します。```.sort``` はすでにRubyのEnumクラスで定義されているため、代わりに```.order```をメソッド名として使っています。

## モデルの状態の保存

サーバーとのデータの同期にはどうしても遅延があります。そこで、モデルが読み込み状態であるかを判断するための ```loaded_state``` というメソッドをストアモデルは提供します。

| 状態        | 説明                                                         |
|-------------|--------------------------------------------------------------|
| not_loaded  | データは読み込まれていません                                 |
| loading     | モデルはサーバーからデータを取得中です                       |
| loaded      | データは読み込まれており、未同期のデータはありません         |
| dirty       | データは読み込まれていますが、サーバーと同期されていません |



