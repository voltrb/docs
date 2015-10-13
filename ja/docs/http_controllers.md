# HTTP コントローラー


HTTPコントローラーはHTTPのエンドポイントとして使うことができます。Voltはクライアントサイドとのほとんどの通信をWebsocket (もしくは他の同等のソケット通信) で行います。したがって、初回のページ読み込み以外では、クライアントとのデータの同期にHTTPを利用しません。(例えばREST APIなどの) HTTP経由でのデータへのアクセスをしたい場合には、HTTPコントローラーを利用すると簡単に外部にデータを提供できます。

## ルーティング

HTTPコントローラーを使うためには、[Routesファイル](routes_file.md) に適切に設定をする必要があります。

## コントローラーの作成

HTTPコントローラーは、```app/component_name/controllers/server/``` 以下に作成し、```Volt::HttpController```を継承します。

```ruby
module Main
  class TodosController < Volt::HttpController
    def index
      #perform some action
    end
  end
end
```

規約として、クラス名は「Controller」で終わる必要があります。Voltでは、```server```フォルダのコードはサーバー側でのみ読み込まれることを示しています。しかし、コントローラー名は、同じコンポーネント内の他のコントローラー (ModelControllerやHttpController) と同じ名前であってはいけません。

## パラメーター

パラメーターには、```#params```メソッドを使うことでアクセス可能です。[コントローラー](controllers.md)のパラメーターとは異なり、```Volt::HttpController``` の ```#params``` は、シンボルをキーとした単純なハッシュになっています。:controller と :action のキーがコントローラーと実行されるアクションを示します。また、:method を上書きすることで、別のHTTPメソッドを設定することも可能です。

## Storeへのアクセス

コントローラー内では、```#store``` メソッドを使うことでstoreへアクセスすることができます。

## Requestのbodyへのアクセス

現在のところ、requestのbodyは手動でパースする必要があります。Bodyにアクセスした場合は、```request``` オブジェクトを利用してください。

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
      data = JSON.parse(request.body.read)
      store._links! << Link.new(data)
    end
  end
end
```

## Requestに対する応答

Requestに対して応答する場合には、```#render```、```#head``` または ```#redirect_to``` メソッドを利用します。

### Responseのレンダリング

Requesに対してResponseを返す場合には、```#render``` メソッドを利用します。```#render``` メソッドは引数にハッシュを受け取ります。```:json``` か ```:text``` のいずれかのキーを設定する必要があります。

```ruby
module Main
  class TodosController < Volt::HttpController
    def show
  	  data = { some: "data" }
  	  render json: data
    end
  end
end
```

デフォルトでは、レンダリングはHTTPステータスコード200を返します。もし変更したければ、引数のハッシュに```status:```を追加することで上書きすることが可能です。他に設定されているキーはすべて、追加のHTTPヘッダとして処理されます。

### リダイレクト

リダイレクトには ```#redirect_to`1` メソッドを使います。その際、第1引数にロケーションを、第2引数にステータスコードを指定してください。デフォルトではステータスコードは302が設定されます。

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
  	  #do something
  	  redirect_to '/todos'
    end
  end
end
```

### head

リダイレクトやリダイレクトを行う必要がない場合には、```#head``` メソッドを使ってステータスコードのみを設定します。

```#head``` は第1引数にステータスコードを受け取り、オプションで第2引数に追加のヘッダをハッシュで受け取ります。ステータスコードにはシンボルを利用することも可能です。詳しくは、 [http://www.rubydoc.info/github/rack/rack/Rack/Utils](http://www.rubydoc.info/github/rack/rack/Rack/Utils) のHTTP_STATUS_CODES セクションを参照してください。

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
    	head :no_content
    end
  end
end
```

### Headers
You can add custom HTTP headers to your response. カスタムヘッダーの内容は変換されます。

例えば、:auth_token は 'Auth-Token' に変換されます。ヘッダーは```Symbol``` または ```String``` で設定することが可能です。
   ```:auth_token == 'Auth-Token' == 'auth-token' == 'Auth_Token'```
