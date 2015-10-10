# 依存関係

別のコンポーネントから [タグ](#tags) (詳しくは後述) を利用することができます。そのためには、そのソースコンポーネントを、使用したいコンポーネント側から require しておく必要があります。これは ```config/dependencies.rb``` ファイルで指定します。単純に

```ruby
component 'component_name'
```

のようにファイルに追加してください。

依存関係は Ruby の ```require``` と同様の働きをしますが、コンポーネント全体を対象とする点が異なります。

外部にホストされている JS ファイルをコンポーネントからインクルードしたいことがあるかもしれません。その場合は、以下のように dependencies.rb ファイルに記載してください。

```ruby
javascript_file 'http://code.jquery.com/jquery-2.0.3.min.js'
css_file '//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css'
```

実際には、現在のところ jquery と bootstrap はデフォルトでインクルードされるようになっていることに注意してください。```javascript_file``` と ```css_file``` でインクルードされた依存関係は、dependencies.rb ファイルに記載されている順序にしたがって、正しい場所にあるコンポーネントのアセットに mix-in されます。
