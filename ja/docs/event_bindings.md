# Event バインディング

Volt のビューでは、DOM にイベントをバインドすることができるので、コントローラー側でメソッドを実行することが可能です。そのためには、e-{イベント名} の属性を付与してください:

```html
<button e-click="alert">Alert Me</button>
```

上記の例では、ボタンがクリックされた際にコントローラーの alert メソッドが実行されます。Volt は内部的には jQuery を利用していますので、jQuery のイベントがサポートされています。1つのタグに対して複数のイベントをバインドすることも可能です。

```html
<button e-click="alert" e-mousedown="alert_pressed_down">Alert Me</button>
```

```event``` というローカル変数を渡すことで、発生した jQuery イベントのオブジェクトをコントローラーに渡すこともできます。

```html
<button e-click="alert(event)">Alert Me</button>
```

コントローラー側では、以下のようにして jQuery イベントのオブジェクトにアクセスします:

```ruby
module Main
  class MainController < Volt::ModelController
    def alert(event)
      event.js_event # the jQuery event
    end
  end
end
```

イベントのオブジェクトは Volt::JSEvent のインスタンスとなります。そのインスタンスは以下のメソッドを持ちます:

### .js_event

jQuery イベントのオブジェクトをそのまま返します。返されるオブジェクトは JavaScript のオブジェクトで Opal のオブジェクトではないので、使用する場合はバッククォート (アクサングラーヴ) か Native を使う必要があります。

### .key_code

押されたキーに対応する int の値を返します。

### .stop!

jQuery イベントに対して stopPropagation() を実行します。

### .prevent_default!

jQuery イベントに対して preventDefault() を実行します。

### .target

対象の DOM ノードを返します。

で修正されましたt {{ file.mtime }}
