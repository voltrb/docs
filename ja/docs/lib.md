# Lib

Volt クライアントとサーバー両方のためのフレームワークです。Gem はクライアントとサーバーの両方で利用されますが、多くの Gem はクライアントとサーバーで互換性がありません。この理由 (および、以下に記載する理由) のために、Volt が起動時にすべての Gem を require することはありません。

### クライアントとサーバー両方で使う Gem

いつも通りに Gemfile と Bundler を使用してください。ただ、上記したように、明示的に Gem を **require** する必要があります。
クライアント **と** サーバー **の両方** で動作する Gem は、```config/app.rb``` で require するのがよいでしょう。

### クライアントのみで使う Gem

ブラウザー上で利用できる Gem もどんどん増えています。Opal の Gem は通常、opal- でプレフィクスされています。
例えば、ブラウザーや  DOM の API を利用するための opal-browser や opal-jquery が良い例でしょう。また、opal-pixi や opal-phantom もあります。

opal-browser などの Gem を利用するには、以下のようにして条件ブロックの中で require してください。そのためには以下のように記述します。

```ruby
if RUBY_PLATFORM == 'opal'
  require "browser"
end

```

また、```config/initializers/client/gems.rb``` といった initializer を用意することも可能です。

```ruby
require "browser"
```

プラットフォームテストを省略できる場合にはこの方法が有効でしょう。

#### Opal のロードパス

クライアントのみで使用する Gem の場合、Opal に Gem のソースを探す場所を教える必要があります。これは、 ```config/dependencies.rb``` で以下のようにします。

```ruby
Opal.use_gem("browser")
```

### クライアントのみで使う Gem

ブラウザーでは動作しない Gem もあります。例えば、Opal は C エクステンションを一切サポートしていません。また、タスクで利用される Gem もサーバー側でのみ読み込まれるべきです。クライアントがネットワークの帯域を余計に利用することを避ける意味でも、ブラウザーが不要な Gem の読み込みを避けるのは好ましいものです。

クライアントの場合と同様に、条件ブロックの中で require してください。

```ruby
if RUBY_PLATFORM != 'opal'
  require "nokogiri"
end
```

```config/initializers/server/gems.rb``` のような initializer を利用することも可能です。

```ruby
require "nokogiri"
```

### Bundler の設定

Gemfileに書かれたGemが自動的にVoltにrequireされることはありません。この動作は以下の理由によるものです。

1. 起動時のパフォーマンスに非常に大きな影響を与えるからです。特にこれは規模が大きくなるにしたがって顕著になります。(これはRailsに対する不満として最もよく耳にするものの1つです)。 dependencies.rbに含まれるコンポーネントGemは、デフォルトでアプリケーションにインクルードされます。
2. 不要なコードが読み込まずに済むからです。
3. どの Gem がクライアントのみで利用されるか、ということを指示することが不可能であるためです。

更なる理由を知りたければ、[5 reasons to avoid Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require) を参照してください。

どうしてもGemを自動的にrequireしたい場合には、```config/app.rb``` の先頭に以下を記載してください。

```ruby
Bundler.setup
```
