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

で修正されましたt {{ file.mtime }}
