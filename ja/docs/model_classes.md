## Model クラス

デフォルトでは、すべてのコレクションは ```Volt::Model``` クラスを使用します。

```ruby
    page._info!.class
    # => Volt::Model
```

標準の Model クラスの代わりに、自分でクラスを用意してそれを読み込むことも可能です。このとき、モデルとするクラスは ```Volt::Model``` を継承している必要があります。クラスは /app/{component}/models フォルダに格納します。例えば、```app/main/info.rb``` などです。

```ruby
    class Info < Volt::Model
    end
```

これで、```_info``` というサブコレクションにアクセスすることができます。それは ```Info``` のインスタンスとして読み込まれるものです。

```ruby
    page._info!.class
    # => Info
```

これによって、コレクションにカスタムメソッドやバリデーションを設定することが可能です。

## ArrayModel クラス

```Volt::ArrayModel``` の代わりに読み込まれるクラスをモデルのフォルダに追加することもできます。通常、store._items のような操作は ```Volt::ArrayModel``` のインスタンスを返しますが、もし models/items.rb クラスを作る場合は以下のようになります。

```ruby
class Items < Volt::ArrayModel
  # Custom array model code, typically this would be queries, factories, etc...
end
```

コレクションへのアクセスがあったとき、上記が自動的にロードされます。
