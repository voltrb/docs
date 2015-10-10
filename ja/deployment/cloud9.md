# Cloud9

Cloud9 で開発したい場合は、Rails のイメージを起動します。(Rails イメージには、必要なものがすべて含まれています)イメージが起動したら、既存のプロジェクトを削除します:

```rm -rf *```

まず Mongo のセットアップをしましょう (Mongo の動作に関するドキュメントはこちらを参照してください(訳注：リンク漏れ？要確認)) 。

新しいターミナルを起動し、以下を入力してください:

```
mkdir data
echo 'mongod --bind_ip=$IP --dbpath=data --nojournal --rest "$@"' > mongod
chmod a+x mongod
```

そして、以下で mongod を起動します:

```
./mongod
```

次に、Volt をインストールします。

```gem install volt```

新しいプロジェクトを作成します。

```volt new projectname```

`cd` でプロジェクトのディレクトリに移動します:

```cd projectname```

それではサーバーを起動しましょう (Cloud9 では、ENV でポート番号とIPアドレスを指定する必要があります)

```bundle exec volt server -p $PORT -b $IP```

Cloud9 はそれぞれのアプリケーションに対してサブドメインを割り当てます。起動しているアプリケーションを開く場合は、```Preview``` メニューをクリックし、```Preview Running Application``` を選択してください。

Cloud9 の無償バージョンでは、mongoDB は定期的にシャットダウンしてしまいます。その対策として、www.mongolab.com で代替の無償の Mongo ストレージセットアップすることが可能です。まずアカウントを登録し、```config/app.rb``` に以下を追加してください。

```
config.db_driver = 'mongo'
config.db_name = (config.app_name + '_' + Volt.env.to_s)
if ENV['MONGOHQ_URL'].present?
  config.db_uri = ENV['MONGOHQ_URL'] # Cloud9 ではこの行が必要です。
else
  config.db_host = 'localhost'
  config.db_port = 27017
end
```


※もし Cloud9 にカスタム Volt イメージを構築したい人がいたら、Gitter で @ryanstout にお知らせください。どうもありがとうございます！
