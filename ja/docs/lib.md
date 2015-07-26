# Lib

**注意:** この章は執筆中です。

Gemfileに書かれたGemが自動的にVoltにrequireされることはありません。この動作は以下の理由によるものです。

1. 起動時のパフォーマンスに非常に大きな影響を与えるからです。特にこれは規模が大きくなるにしたがって顕著になります。(これはRailsに対する不満として最もよく耳にするものの1つです)。 dependencies.rbに含まれるコンポーネントGemは、デフォルトでアプリケーションにインクルードされます。
2. 不要なコードが読み込まずに済むからです。

更なる理由を知りたければ、[5 reasons to avoid Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require) を参照してください。

どうしてもGemを自動的にrequireしたい場合には、```config/app.rb``` の先頭に以下を記載してください。

```ruby
Bundler.setup
```

で修正されましたt {{ file.mtime }}
