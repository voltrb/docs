# Opal の Gem を利用できますか?

はい。Opal は独自の方法で Gem をinclude します。このことは、通常、Opal のロードパスに追加される前に、MRI コードで Gem を require する必要があることを意味しています。

例えば opal/browser を例にすると、単純に以下のように config/app.rb に追加することが可能です。

```ruby
require 'opal/browser'
```

そして、opal-browser を利用したいコントローラーで、ファイルの先頭に以下を追加します:

```ruby
if RUBY_PLATFORM == 'opal'
  require 'browser'
end
```
