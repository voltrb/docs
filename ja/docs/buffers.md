## バッファ

ストアコレクションは自動的にバックエンドと同期するため、モデルのプロパティに対する更新は、他のクライアントにも即座に反映されます。しかし、この動作が望ましくない場合もあるでしょう。[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)アプリケーションの構築を容易にするため、Voltは"バッファ"という方法を的供します。バッファはモデルに対して作成することが可能で、save! を実行するまではバックエンドのモデルに反映されることはありません。これを利用することで、submit ボタンが押されるまでは保存されないフォームを作成することが可能になります。

```ruby
    store._items << {name: 'Item 1'}

    item1 = store._items[0]

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
```

なお、バッファに対して ```#save!``` を実行したときの戻り値は [promise](http://opalrb.org/blog/2014/05/07/promises-in-opal/) です。promise はデータがサーバーに保存された時点で解決 (resolve) されます。

```ruby
    item1_buffer.save!.then do
      puts "Item 1 saved"
    end.fail do |err|
      puts "Unable to save because #{err}"
    end
```

既存のモデルに対して .buffer を実行した場合の戻り値は、そのモデルのインスタンスのバッファになります。また、Volt::ArrayModel (複数形のサブコレクション) に対して .buffer を実行した場合には、そのコレクションの新しい要素のバッファを取得します。save! を実行すると、<< で要素をコレクションにプッシュするかのように、その要素をサブコレクションに追加することができます。
