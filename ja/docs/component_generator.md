## コンポーネント ジェネレーター

コンポーネントは gem で簡単に共有することができます。Volt は コンポーネントの gem のための scaffold を提供します。In a folder (Volt プロジェクト以外の) フォルダーの中で、volt gem {コンポーネント名} を実行すると、gem が必要とするファイル群を生成することできます。すべての Vott コンポーネントの gem の名前には volt- が付きます。これによって、github や rubygems で見つけやすくなります。

開発中は、Gemfile に以下のように記載することで、そのコンポーネントを使用することができます:

```ruby
gem 'volt-{コンポーネント名}', path: '/path/to/folder/with/component'
```

gem の準備が整ったら、以下のようにして ruby gems にリリースすることができます。

    rake release

Rubygems のバージョンを利用する場合には、Gemfile の path: オプションを削除してください。
