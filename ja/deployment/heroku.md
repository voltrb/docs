## Heroku

以下のように、```Gemfile``` に Ruby のバージョンを指定します。

```ruby
source 'https://rubygems.org'

ruby "2.1.3" # Ruby バージョンの指定

gem 'volt', '0.8.22'
```

```Procfile``` を追加し、Thin を利用するように指定します。

    web: bundle exec thin start -p $PORT -e $RACK_ENV

```/config/app.rb``` にデータストアの接続設定を記載します。以下は MongoHQ の場合の設定例です。利用するプロバイダーにあわせて適宜変更してください。


```ruby
config.db_driver = 'mongo'
config.db_name = (config.app_name + '_' + Volt.env.to_s)

if ENV['MONGOHQ_URL'].present?
  config.db_uri = ENV['MONGOHQ_URL']
else
  config.db_host = 'localhost'
  config.db_port = 27017
end
```
