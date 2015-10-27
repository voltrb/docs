# タスク

明示的にサーバー上でコードを実行したいこともあるでしょう。Volt では *タスク* を使ってこの問題を解決します。タスクは ```Volt::Task``` を継承することで定義できます。```tasks``` フォルダーに格納された ```_tasks.rb``` で終わる名前の Ruby ファイルは自動的に require されます。

```ruby
# app/main/tasks/logging_tasks.rb

class LoggingTasks < Volt::Task
  def log(message)
    puts message
  end
end
```

このとき、Volt は自動的に、promise を返すラッパーをクライアントサイドで生成します。

*サーバーサイドのクラスはインスタンスメソッドを使いますが、ラッパークラスにおいては、それらのメソッドがクラス・メソッドとなることに注意してください。* Ruby で promise を利用することについてのより詳しい情報は [こちら](http://opalrb.org/blog/2014/05/07/promises-in-opal/) を参照してください。

```ruby
class Contacts < Volt::ModelController
  def hello
    promise = LoggingTasks.log('Hello World!')
  end
end
```

戻り値の promise に対して ```#then``` メソッドを実行すると、その呼び出しの結果を得ることができます。また、スローされたエラーを取得したければ、promise に対して ```#fail``` を実行します。

```ruby
MathTasks.add(23, 5).then do |result|
  # result should be 28
  alert result
end.fail do |error|
  puts "Error: #{error}"
end
```

## タイムアウト

デフォルトでは、タスクには60秒のタイムアウトが設定されています。すべてのタスクに対するグローバルなタイムアウト時間を設定したい場合には、```config/app.rb``` で ```config.worker_timeout``` を設定してください。また、タスクごとにタイムアウト時間を変更したい場合は、そのクラスで ```timeout``` メソッドを実行します。

```ruby
class SampleTask < Volt::Task
  timeout 200

  ...
end
```

タイムアウト時間を0にすることでタイムアウトを無効にすることが可能です。

## Cookies

タスク内で```cookies``` を利用すると、新しい cookie を設定することができます。設定された cookie はクライアントに送信され設定されます。注意: タスクの中では cookie のセットのみが可能で、読み込むことはできません。(これはパフォーマンス上の理由による仕様です)
