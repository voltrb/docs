# Component Gem

コンポーネントは gem で簡単に共有することができます。Volt は コンポーネントの gem を作成するための scaffold コマンドを提供します。(Volt プロジェクト以外の) フォルダーの中で、```volt generate gem {コンポーネント名}``` を実行してください。すると、gem が必要とするファイル群を生成することできます。すべての Vott コンポーネントの gem の名前には ```volt-``` が付きます。これによって、github や rubygems で見つけやすくなります。Gemの命名規約にしたがって、コンポーネント名はアンダースコア区切りにする必要があります。

開発中は、Gemfile に以下のように記載することで、そのコンポーネントを使用することができます:

```ruby
gem 'volt-{コンポーネント名}', path: '/path/to/folder/with/component'
```

gem の準備が整ったら、以下のようにして rubygems にリリースすることができます。

```
rake release
```

Rubygems のバージョンを利用する場合には、Gemfile の ```path:``` オプションを削除してください。
