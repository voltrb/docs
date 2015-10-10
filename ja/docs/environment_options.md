# Environment オプション

config/app.rb で指定するオプションに加えて、Volt では、インスタンス変数を利用して、いくつかのインスタンスに固有のオプションを構成することができます。

| 名前                   | 詳細                             |
|------------------------|-----------------------------------------|
| VOLT_ENV               | Volt.env の値を設定します。この値はアプリケーションの様々な箇所で利用されます。|
| RACK_ENV               | これも、Volt.env を設定するのに利用します。       |
| NO_MESSAGE_BUS         | メッセージバスを無効にします。これにより、Volt インスタンス間で更新を伝え合うことができなくなりますが、デバッグの際に有用です。 |
| NO_FORKING             | "フォークサーバー" は MRI での開発でコードの再読み込みをするために使用します。(コネクションのために子プロセスをフォークし、コードの変更時に再度フォークして kill されます)。フォークを無効にすると、タスク、HttpController、ルーティングなどでのコードの再読み込みができなくなります。|
| WEBSOCKET_PING_TIME    | 有効な場合、WebSocket のコネクションは ```WEBSOCKET_PING_TIME``` ごとに ping を送信します。|
| NO_WEBSOCKET_PING      | WebSocket ping は (DYNO env が有効な) Heroku のみで有効で、Heroku がアイドル状態のコネクションを切断することを回避します。これは、WebSocket ping を強制的に無効にします。 |
| SKIP_BUNDLER_REQUIRE   | Gemfile の自動 require を無効にします。この機能は現在 experimental です。|
| POLL_FS                | Volt はリッスン用の Gem を利用して自動更新のためにファイルシステムの変更検知を行いますが、変更が正しく検知できない場合があります。そのような場合には、POLL_FS=true を設定することで変更を poll することが可能です。例えば、ネットワーク越しにファイルを共有している場合などにこの状況が発生します。|
| DB_NAME                | Volt.config.db_name と同様            |
| DB_HOST                | Volt.config.db_host と同様            |
| DB_PORT                | Volt.config.db_port と同様            |
| DB_DRIVER              | Volt.config.db_driver と同様          |
| DB_URI                 | Volt.config.db_uri と同様             |
