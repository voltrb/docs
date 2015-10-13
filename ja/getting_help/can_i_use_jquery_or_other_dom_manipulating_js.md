# jQuery やその他の DOM 操作の JS を使うことができますか？

YES！現在、Volt は jQuery をバンドルしています (ただし、将来的には削除される予定です)。(Volt で jQeury を使うのはいつでも可能ですが) Volt においては jQuery の利用は2種類にわけられます。

1. Volt のコントローラーから (Opal 経由で) JS を実行する
2. 適切なタイミングで DOM にバインドするためのアクションコールバックを利用する

## DOM へのアクセス

コントローラーのアクションが呼び出されたとき、DOM はそのアクションの後でレンダリングされます。Volt はアクションの前後に[いくつかのコールバック](../docs/callbacks_and_actions.html)を実行しますが、アクションによって生成された DOM を扱うには ``` _ready ``` コールバックを利用します。

Volt がビューをレンダリングするときには、通常その結果として (1つだけではなく) 多くの DOM ノードができます。Volt は (``` index_ready ``` といった) コールバックから DOM にアクセスするのに3つの方法を用意しています。

- self.dom_nodes
- self.first_element
- self.container

### dom_nodes

`dom_nodes` はビューの「すべての」ノードを表す [Range](https://developer.mozilla.org/en-US/docs/Web/API/Range) オブジェクトを返します。ただ、それらには空白も含まれており、直接触るには少々扱いが厄介です。

### first_element

`first_element` を使うと最初の [Element](https://developer.mozilla.org/en-US/docs/Web/API/Element) (DOM ノードとも呼ばれる) を取得できます。多くの場合、欲しいものはこれでしょう。もしビューが単一のルート要素 (div など) を持っている場合、first_element はその前にある空白を無視してその要素を返します。定番のパターンとして、最初の要素を取得し、それから、その要素を利用してビューの要素の問い合わせを行います。

``` `$(#{first_element}).find('.tab-header')` ```

上記の例では、バックティック (バッククォート) でくくって jQuery の $(..) を実行し、それから #{} を使って (Ruby の世界に戻って) Volt の ```first_element``` を実行しています。これによって、ビュー (ビューには単一のルートノードがあるとして) を表すノードを jQuery でラップしたものが手に入ります。それから、```.find``` によって目的のノードを問い合わせています。

### container

`container` は `dom_nodes` の [common ancestor](https://developer.mozilla.org/en-US/docs/Web/API/Range/commonAncestorContainer)、言い換えると `first_element` の「親」提供します。これはビューに複数のルートノードがある場合に便利です。例えば、ビューの一部が以下のようになっている場合を考えてください。

```html
<td>{{ name }}</td>
<td>{{ address }}</td>
```

上記では、ビューは2つのルートノード (td) を持っているため、first element は最初の ```td``` を返します。```container``` を使うと、2つの ```td``` の親のノードが手に入ります。

これらすべての (Ruby) の関数は JavaScript のオブジェクトを返します。したがって、これらのオブジェクトを Ruby で直接扱うことはできず、そのためにはバックティックか、もしくは Native モジュールを使う必要があります。どちらもこれから説明します。

もちろん、jQuery を使って、特定の id や CSS セレクタ検索などによるある要素の DOM を探すこともできますが、それらはおそらく複雑で、すぐに動かないものになってしまうでしょう。

## Volt から JS を実行する

はじめに、Volt から JS のコードを  (Opal 経由で) 実行する方法を見ていきましょう。Opal のドキュメントは [こちら](http://opalrb.org/docs/compiled_ruby/) です。一般的には、JS のコードはバックティックを使って  (``` ` JS のコード ` ```) インラインで実行できます。
このような JavaScript のコードは Ruby のローカル変数へアクセスできます。

もしコントローラーのメソッドをサーバーとクライアントの両方で利用したいのであれば、Opal の場合にのみ実行するようにする必要があります。そのためには以下のようにします。

```ruby
class PostController < Volt::ModelController
  def show_ready
    if RUBY_PLATFORM == 'opal'
        # run some JS code
        first = first_element
        `$(first).find(".some_class")`
    end
  end
end
```

ここでは jQuery を使って要素をラップし、クラスを指定することで要素を問い合わせています。このように、バックティックの中の JavaScript が first というローカル変数にアクセスできています。しかし、first_element という関数はそこでは利用できません。

より Ruby っぽい方法で JavaScript を利用するには、例を後述する [Native](http://dev.mikamai.com/post/79398725537/using-native-javascript-objects-from-opal) モジュールを使います。

## アクションを利用する

DOM バインディングを管理するときには、ビューがレンダリングされた後にそれらを設定し、ビューが削除される前に**削除**しなければなりません。

```ruby
class Post < Volt::ModelController
    def show_ready
        # example setup JS
        first = first_element
        `first.setupCodeHighlighting();`
    end

    def before_show_remove
        # example teardown JS
        first = first_element
        `first.cleanupCodeHighlighting()`
    end
end
```

これらの例は JavaScript のセットアップ/クリーンアップ関数を使うものです。Ruby の関数を使うには、後述の native を使うアプローチについて確認してください。

## ビューの DOM ノードを取得する


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
    def show_ready
        post = self.container
        `post.setupCodeHighlighting()`
    end
end
```

Opal では、ローカル変数は JS のローカル変数にコンパイルされます。したがって、```post``` に ```#container``` を実行して代入することができます。そうすれば、JS の内部で ```post``` 変数にアクセスすることが可能です。このように、jQuery にコンテナノードを渡し、それに対してメソッドを実行することが可能です。

### Native を使って JS のオブジェクトをラップする

Native を使うには、まずコントローラーで require する必要があります。

```ruby
if RUBY_PLATFORM == 'opal'
  require "native"
end
```

そして、以下のように Ruby だけでコントローラーのアクションを構成することができます。

```ruby
class PostController < Volt::ModelController
  def show_ready
      setupCodeHighlighting( Native(self.container) )
  end
end
```

このケースでは、``` setupCodeHighlighting ``` という Ruby メソッドがラップされた [Element](http://www.w3schools.com/jsref/dom_obj_all.asp) を受けとっています。それによって、Ruby のメソッドで JS のプロパティにアクセスすることができるようになっています。
