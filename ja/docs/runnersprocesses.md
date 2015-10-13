# ランナー/プロセス

通常のリクエストのサイクルの外で実行したいコードがあるときには、以下の2つの方法のいずれかで可能です。

## 1) ランナー

例えば ```app/main/lib/some_runner.rb``` のように lib にコードを格納し、以下のコマンドでそのコードを実行することができます。

```bundle exec volt app/main/lib/some_runner.rb```

ランナーのコマンドは、.rb ファイルのコード実行する前に、現在のアプリケーションの設定を読み込みます。

## 2) アプリケーションの起動

もし Volt アプリケーションを別のコンテキストでロードする必要がある場合です。例えば、[clockwork](https://github.com/tomykaira/clockwork) Gem を利用する場合や、独自のコマンドを使う Gem を利用する場合は、以下のようにしていつでも Volt アプリケーションを起動できます。

```ruby
require 'volt/boot'
Volt.boot(Dir.pwd)
```

```Volt.boot``` の引数は1つで、Volt アプリケーションのディレクトリのパスを指定します。実行するアプリケーションの Gemfile を使って ```bundle exec``` で実行してください。そうすれば、Volt とその依存関係も読み込むことができます。
