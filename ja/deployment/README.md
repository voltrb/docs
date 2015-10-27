# Volt のデプロイ

## production 環境での実行

アプリケーションをデプロイする場合は、VOLT_ENV=production の環境変数を設定することを推奨します。これによってコードのリローディングとソースマップが無効になり、いくつかのパフォーマンスを向上させる設定が有効になります (ロードに要する時間は増加します) 。

## アセットのプリコンパイル

Volt では、すべてのアプリケーションのアセットを /public にプリコンパイルすることが可能です。プリコンパイルにおいて、Volt は以下のことを行います。

1. すべての Opal ファイルのプリコンパイル
2.  JS/Opal JS の minify ([uglifier](https://github.com/mishoo/UglifyJS2) を利用)
3. CSS の minify ([csso](https://github.com/css/csso) を利用)
4. CSS と JavaScirpt をそれぞれ単一のファイルに結合する (クライアント上でのリクエスト回数を減らすため)
5. すべての画像の非可逆圧縮とメタデータの除去 ([image-optim](https://github.com/toy/image_optim) の様々なツールを利用)
6. 永久的なキャッシュのための fingerprint を用いたアセットのリネーム(ファイルに変更があれば、新しい fingerprint が生成されて紐付けられる)

すべてのアセットは /public フォルダにコンパイルされ、[Nginx](http://nginx.org/) などが直接サーブすることが可能です。プリコンパイルを行った結果、最初のページ読み込み速度をはっきりと向上させ、ブラウザからのリクエスト数を減少させることができます。

アプリケーションのアセットをプリコンパイルするには、単純に以下を実行します。

```VOLT_ENV=production bundle exec volt precompile```

### アセットのキャッシュ

アセットのプリコンパイルによって、css/sass/html ファイルから参照される画像をコンポーネントから public フォルダにコピーします。すべてのアセットは、プリコンパイルの際に fingerprint のハッシュが末尾に追加された名前 (```profile-``` など) にリネームされることに気がつくでしょう。これによって、public フォルダ内のすべての画像やフォントなどを永久的にキャッシュすることができるようになっています。ファイルの中身が変更された場合は、新しいハッシュが割り当てられます。(これは Rails で行われるプロセスと同様です。詳しくは、[こちらのより詳細なドキュメント](http://guides.rubyonrails.org/asset_pipeline.html)を参照してください) 。

アセットを正しく示すための画像のタグや CSS などについては、[アセット](docs/assets.md)のセクションを参照してください。

### カスタム Socket URL

Volt は、すべてのデータベースへの問い合わせや更新、そしてタスクの呼び出しなどを、[websocket](https://en.wikipedia.org/wiki/WebSocket) の通信によって行います。Websockets は既存の HTTP コネクションを「アップグレード」することによって作られます。通常、Volt は既存の HTTP コネクションを利用して websocket のコネクションをセットアップします。しかし、異なるポートやドメインなどを使って websocket に接続したいケースもあるでしょう。(一般的に、メインのアプリケーションが websocket に非対応なプロキシサーバーの背後で動作している場合に必要となります) 。websocket の URL は ```config/app.rb``` で以下のように設定可能です。

```ruby

Volt.configure do |config|
  # ...

  config.public.websocket_url = 'websocket.mysite.com/socket'
  ...
end
```

Volt は、指定がない場合は、自動的に ws:// もしくは wss:// を URL の先頭に追加します。

## ホスティングサービス

この章の残りでは、有名なクラウドサービスへのデプロイ方法に焦点を当てて説明します。
