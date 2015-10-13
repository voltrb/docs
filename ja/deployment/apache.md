# Apache

Websockets をサポートしていません。[詳しくはこの投稿を参照](https://github.com/phusion/passenger/issues/1202)してください。
したがって、Apache を [thin](http://code.macournoyer.com/thin/) に対するフォワードプロキシとして扱う必要があります。
Apache に対して、以下のモジュールを有効にしてください。
- [mod_proxy](http://httpd.apache.org/docs/2.4/mod/mod_proxy.html)
- [mod_proxy_wstunnel](http://httpd.apache.org/docs/2.4/mod/mod_proxy_wstunnel.html)

```
<VirtualHost *:80>
  ServerName YOUR.SERVER.NAME
  DocumentRoot /PATH/TO/APP_NAME/public

  ProxyRequests Off
  ProxyPreserveHost On

  # a2enmod proxy_wstunnel
  ProxyPass /socket  ws://localhost:3001/socket
  ProxyPassReverse /socket  ws://localhost:3001/socket
  ProxyPass / http://localhost:3001/
  ProxyPassReverse / http://localhost:3001/

  LogLevel warn

  CustomLog ${APACHE_LOG_DIR}/APP_NAME_access.log combined
  ErrorLog ${APACHE_LOG_DIR}/APP_NAME_error.log
</VirtualHost>
```

`thin install` でサービスとしてインストールし、`/var/thin/volt.yml` に以下の構成ファイルを追加してください。

```
---
chdir: "/PATH/TO/APP_NAME"
environment: production
address: 0.0.0.0
port: 3001
timeout: 30
log: "/var/log/thin-expenses.log"
pid: tmp/pids/thin.pid
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
servers: 1
daemonize: true
```

その後、`sudo /etc/init.d/thin start` で thin を起動してください。
