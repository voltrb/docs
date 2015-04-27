# Before/After フィルター

コントローラーでレンダリングを行う際に、アクションが実行される前後に何らかの処理を実行したい場面がしばしばあります。Voltは```before_action```と```after_action```のメソッドを提供しており、それらを使うことで「beforeアクション」と「afteアクション」を設定することが可能です。以下のようにして設定します。

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :english_only

    # require_loginはVolt::ModelControllerのメソッドです
    before_action :require_login, only: :about

    def index
      # indexの設定…
    end

    def about
      # aboutの設定…
    end

    # ロケールが英語でなければリダイレクト
    # (あくまでも例です)
    def english_only
      if `navigator.language` != 'en-US'
        redirect_to '/translations'
        stop_chain # 詳細は後述
      end
    end
  end
end
```

アクションはメソッド名のシンボル以外にブロックをとることもできます。

## 特定のアクションにのみ適用

特定のアクションのみにフィルターを適用させたい場合は、```only: :some_action``` を引数に指定します。```only``` はシンボルかシンボルの配列のいずれかを設定することが可能です。

# stop_chain

beforeフィルターでリダイレクトを実行する方法はごく一般的に使われます。レンダリングを途中で停止したい場合は、アクションで```stop_chain```を呼び出せば、そこでレンダリングは停止します。

```stop_chain``` はfilter runnerによって補足される例外を発生させますので、```stop_action```以降のコードが実行されることはありません。
