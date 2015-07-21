## バッファ

Volt のすべてのモデルは、変更を自動的にその persistor に対しても保存します。例えば、```store``` 上のモデルに対して、その ```name``` プロパティの変更を行ったとき、その変更は自動的にデータベースと他のクライアントに同期されます。他の多くのフレームワークと異なり、明示的に save を実行する必要はありません。モデルはプロパティの変更に応じて即座に同期されます。

```ruby
store._items.first.then do |item|
    item._name = 'New Item Name'
    # ...syncs back to db
end
```

もう1つ例をあげます。パラメータの ```index``` プロパティに変更を加えた際、index の変更に応じて即座に URL も更新されます:

```ruby
params._index = 20
# ...url 更新
```

ストアコレクションは自動的にバックエンドと同期するため、モデルのプロパティに対する更新は、他のクライアントにも即座に反映されます。しかし、この動作が望ましくない場合もあるでしょう。[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)アプリケーションの構築を容易にするため、Voltは"バッファ"という方法を的供します。バッファはモデルに対して作成することが可能で、```save!``` を実行するまでは、そのバッファの元になったモデル(バックエンドのモデル)に反映されることはありません。これを利用することで、submit ボタンが押されるまでは保存されないフォームを作成することが可能になります。

```ruby
store._items << {name: 'Item 1'}

store._items[0].then do |item1|
  item1_buffer = item1.buffer

  item1_buffer._name = 'Updated Item 1'
  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Item 1'

  item1_buffer.save!

  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Updated Item 1'
end
```

なお、バッファに対して ```#save!``` を実行したときの戻り値は [promise](http://opalrb.org/blog/2014/05/07/promises-in-opal/) です。promise はデータがサーバーに保存された時点で解決 (resolve) されます。

```ruby
item1_buffer.save!.then do
  puts "Item 1 saved"
end.fail do |err|
  puts "Unable to save because #{err}"
end
```

既存のモデルに対して .buffer を実行した場合の戻り値は、そのモデルのインスタンスのバッファになります。また、Volt::ArrayModel に対して .buffer を実行した場合には、そのコレクションの新しい要素のバッファを取得します。save! を実行すると、```<<``` または ```create``` で要素をコレクションにプッシュするかのように、その要素をサブコレクションに追加することができます。will then add the item to that sub-collection as if you had done ```<<``` or ```create``` to push the item into the collection.

で修正されましたt {{ file.mtime }}
