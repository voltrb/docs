## リアクティブ アクセサ

デフォルトの ```Volt::ModelController``` は、自分に見つからないメソッドをそのモデルにプロキシします。しかし時には、追加のデータをリアクティブな状態で、かつコントローラーに保持させて、モデルの外側に持っておく必要があるかもしれません。(普通であれば、別のコントローラーの実装を検討するときかもしれませんが)。こういった場合、```reactive_accessor``` を使用します。それらは ```attr_accessor``` と同様の振る舞いをします。ただし、追跡して評価されるので、代入される値と戻り値はリアクティブに評価された結果となります。

```ruby
module Main
  class Contacts < Volt::ModelController
    reactive_accessor :query
  end
end
```

これで、```query``` をビューからバインドすることができます。while also changing in and out the model. query へのアクセスは追跡され、変更があった際には評価が実行されます。
