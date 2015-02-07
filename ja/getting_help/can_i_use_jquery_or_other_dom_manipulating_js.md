# jQuery やその他の DOM 操作の JS を使うことができますか？

使えます！現在、Volt は jQuery をバンドルしています (ただし、将来的には削除される予定です)。(Volt で jQeury を使うのはいつでも可能ですが) Volt においては jQuey の利用は2種類にわけられます。

1. Volt のコントローラーから (Opal 経由で) JS を実行する
2. 適切なタイミングで DOM にバインドするためのアクションコールバックを利用する

## Volt から JS を実行する

注意: 以下の内容は 0.8.27.beta3 以上の場合のみ該当します。

まず、どのように JS のコードを Volt から (Opal を経由して) 呼び出すのか、について記載します。Opal のドキュメントは[こちら](http://opalrb.org/docs/compiled_ruby/)です。JS を呼び出すための最も基本的な方法は、バッククォート (``` ` ```) を使ってインラインで実行するものです。もしコントローラーのメソッドをサーバーとクライアントの両方で利用したいのであれば、Opal の場合にのみ実行するようにする必要があります。そのためには以下のようにします。

```ruby
class PostController < Volt::ModelController
  def show_rendered
    if RUBY_PLATFORM == 'opal'
        # run some JS code
        `$('.post').setupCodeHighlighting()`
    end
  end
end
```

## アクションを利用する

Volt は、ビューのレンダリングライフサイクルに対してのコールバックを提供します。詳細は[コールバックとアクション](callbacks_and_actions.html)を参照してください。DOM バインディングを管理するときには、ビューがレンダリングされた後にそれらを設定し、ビューが削除される前に削除しなければなりません。

```ruby
class Post < Volt::ModelController
    def show_rendered
        # example setup JS
        `$('.post').setupCodeHighlighting();`
    end

    def before_show_remove
        # example teardown JS
        `$('.post').cleanupCodeHighlighting()`
    end
end
```

## ビューの DOM ノードを取得する

しばしば、1つのページがビューが複数回レンダリングされることがあります。こういったケースでは、コントローラーのどの DOM ノードのビューが保持しているのかを知りたい場合があります。現在のところ、Volt はバインディングに id を設定することができません。(これは将来的には変更になる予定です)。しかし、Volt の ```ModelController``` が DOM ノードにアクセスするための2つの方法を提供しています。

```
class Post < Volt::ModelController
    def show
        self.container # コンテナノードを返す
        self.dom_nodes # ノードの range を返す
    end
end
```

Volt のビューはルートレベルに複数の DOM ノードを持つことができるため、以下のようなことが可能です。

##### main.html

```html
<ul>
    {{ posts.each do |post| }}
        <:post model="{{ post }}" />
    {{ end }}
</ul>
```

#### post.html

```html
<li>{{ post._title }}</li>
<li>{{ post._date }}</li>
```

ビューは単一のルートノードを持っているわけではないので、 ```#dom_nodes``` は JS の range を返します。その中でクエリ操作を行います。もし、(上記した例の中で示したような、ノードの上位に位置する) 共通のルートノードが必要であれば、```#container``` を実行してください。

## コンテナの利用例

```ruby
class Post < Volt::ModelController
    def show
        post = self.container
        `$(post).setupCodeHighlighting()`
    end
end
```

Opal では、ローカル変数は JS のローカル変数にコンパイルされます。したがって、```post``` に ```#container``` を実行して代入することができます。そうすれば、JS の内部で ```post``` 変数にアクセスすることが可能です。このように、jQuery にコンテナノードを渡し、それに対してメソッドを実行することが可能です。
