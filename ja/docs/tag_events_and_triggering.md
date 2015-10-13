# タグイベントとトリガー

タグを利用すると、あるタグが設定されていた場合に、イベントをコントローラーからトリガーすることが可能になります。

例:


```html
<:upload e-uploaded="was_uploaded" />
```

上記の例では、コントローラーが 'uploaded' イベントを起動したときに、upload ボタンに e-uploaded イベントバインディングのコードを実行させることができます。

以下はトリガーの例です。

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... アップロードのハンドリング ..

      # uploaded イベントのトリガー
      trigger('uploaded')
  end
end
```

タグイベントは DOM の親要素にも伝わっていきます。したがって、上位の (どのタグ要素の) DOM でもイベントをキャッチすることができます:

```html
<div e-uploaded="was_uploaded">
  <p>
    Upload 1:
    <:upload />
  </p>
  <p>
    Upload 2:
    <:upload />
  </p>
</div>
```

上記の例において、```was_uploaded``` は2つの upload タグのうちいずれかが uploaded イベントをトリガーすると呼び出されます。

## 引数の受け渡し

イベントをトリガーするときに引数を渡すことができます。

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... アップロードのハンドリング ..

      # uploaded イベントのトリガー
      trigger('uploaded', file_name)
  end
end
```

上記の例では、file_name という引数をイベントに渡しています。タグを使っているビューのためのコントローラー側の ```was_uploaded``` メソッドは以下のようになります:

```ruby
module Main
  class MyDocumentsController < Volt::ModelController
    def was_uploaded(file_name)
      # ... ファイルへの操作 ...
    end
  end
end
```

イベント名の後でトリガーに渡した引数はすべて、e- バインディングのメソッドに渡されます。

## コントローラーの取得

イベントバインディングが呼び出したメソッドに (トリガーされたときの数に対して) 追加の引数が与えられていた場合、イベントバインディングは ```JSEvent``` に渡します。(詳細は [イベントバインディング](event_bindings.md) を参照) ```JSEvent``` から、(DOM イベントではない場合は) ```event.controller``` を実行することで、そのイベントを呼び出したコントローラーを取得することができます。

## Methodizing

以下は技術的な詳細になりますが、知っていることで役に立つことがあるでしょう。

e- バインディングに渡された文字列は、渡した内容にしたがって、Proc もしくは Ruby の Method オブジェクトのいずれかに変換されます。もしカッコを最後につけて渡した場合、カスタム引数を渡すことを意図したメソッドコールだと解釈されます。

```<:upload e-uploaded="was_uploaded('done')" />```

上記の場合は Proc に変換され、uploaded イベントがトリガーされたときに呼び出されます。文字列の最後にカッコがない場合は、メソッドへの参照を渡していると解釈され、(文字列を ```method(:last_part_str)``` と変更することで) メソッドに変換されます。 

例えば、以下のようになります。

```<:upload e-uploaded="upload_handler.was_uploaded" />```

e-uploaded イベントバインディングは以下を受け取ります:

```ruby
upload_handler.method(:was_uploaded)
```
