## リアクティブ アクセサ

デフォルトの ModelController は、自分に見つからないメソッドをそのモデルにプロキシします。しかし時には、追加のデータをリアクティブな状態で、かつコントローラーに保持させて、モデルの外側に持っておく必要があるかもしれません。(Though often you may want to consider doing another control/controller).  こういった場合、```reactive_accessor``` を使用します。それらは ```attr_accessor``` と同様の振る舞いをします。ただし、追跡して評価されるので、代入される値と戻り値はその評価された結果となります。

```ruby
  class Contacts < Volt::ModelController
    reactive_accessor :query
  end
```

これで、query をビューからバインドすることができます。while also changing in and out the model.  You can also use ```reactive_reader``` and ```reactive_writer```. When query is accessed it tracks that it was accessed and will any Computations when it changes.
