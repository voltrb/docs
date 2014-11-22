# タスク

明示的にサーバー上でコードを実行したいこともあるでしょう。Volt では *タスク* を使ってこの問題を解決します。タスクは ```Volt::TaskHandler```.を継承することで定義できます。```tasks``` フォルダーに格納された ```_task.rb``` で終わる名前の Ruby ファイルは自動的に require されます。すべてのタスクは ```Volt::TaskHandler``` を継承しなければなりません。

```ruby
    # app/main/tasks/logging_tasks.rb

    class LoggingTasks < Volt::TaskHandler
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

