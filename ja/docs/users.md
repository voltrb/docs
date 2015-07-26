# ユーザー

ユーザーは、多くの Web アプリケーションにおいて中心となるコンポーネントの1つです。Volt はユーザーをフレームワークに取り込むことで標準化しています。

## メモ

Voltのユーザーに関する機能は開発中の段階です。サードパーティのサービス経由でログインできるように、[omniauth](https://github.com/intridea/omniauth) のサポートを計画中です。現在は E メールまたはユーザー名とパスワードのオプションのみが提供されています。

## ユーザーを利用する

Volt は [volt-user-tempates](https://github.com/voltrb/volt-user-templates) gem を最初から組み込んでいます。まず、ユーザーの使いかたについて見てみましょう。その次に、独自のサインアップページとログインページの作成方法について説明します。

volt-user-template はサインアップとログインのためのテンプレートを提供します。それらは、デフォルトのルーティングテンプレートによってレンダリングされます。Volt は ```/signup``` と ```/login``` を ```routes.rb``` に定義しています。タグを使ってテンプレートのレンダリングをすることも可能です。詳しくは、[volt-user-templates の readme](https://github.com/voltrb/volt-user-templates) を参照してください。

現在のユーザーモデルには ```Volt.current_user``` でアクセスすることができます。これは最初はnilを返しますが、サーバーからデータが取得でき次第、ユーザーのデータがリアクティブに更新されます。もしユーザーが返ってくるまで待つ必要がある場合には、```Volt.fetch_current_user```を利用することができます。これは、ユーザーが読み込まれたときに解決するpromiseを返します。もしユーザーがログインしていなれければnilで解決します。

## 制限付きモデル

Volt は、モデルの変更をある特定のユーザーのみに制限するためのヘルパーを備えています。詳細は[パーミッション](#permissions) を参照してください。

## ログイン

ユーザーのログインは以下を実行します:

```ruby
Volt.login(login, password)
```

上記において、```login``` は、ユーザー名か E メールのいずれかを使うように設定することができます。```Volt.login``` は [promise](http://opalrb.org/blog/2014/05/07/promises-in-opal/) を返し、ログインに成功した場合に解決 (resolve) され、ログインに失敗した場合には、エラーメッセージとともに失敗 (fail) します。

```ruby
Volt.login(email, password).then do
  # ログイン成功時はリダイレクト
  go '/dashboard'
end.fail do |error|
  # ログイン失敗 (エラーあり)
  flash._errors << error
end
```

## ログアウト

ユーザーのログアウトは以下を実行します:

```ruby
Volt.logout
```

これは即座に実行され、```Volt.current_user``` に対して変更 (change) イベントをトリガーします。

## ユーザーを作成する

ユーザーを作成する例は [volt-user-templates](https://github.com/voltrb/volt-user-templates) を見てください。

Volt は ```Volt::User``` クラスを備えており、すべてのモデルが継承することができます。デフォルトでは、Volt は、```app/main/models/user.rb``` で User モデルを提供しています。

ログインのために ```Volt::User``` がデフォルトで使うのは ```email``` プロパティですが、代わりに ```username``` を使うようにアプリケーションを構成することもできます。そのためには、```config/app.rb``` に以下を追加してください。

```ruby
config.public.auth.use_username = true
```

```Volt::User``` は、```email``` や ```username``` に対してのバリデーションも提供しています。パスワードは ```password``` プロパティに格納されます。パスワードは [bcrypt](https://github.com/codahale/bcrypt-ruby) を使ってハッシュ化され、 ```hashed_password``` に格納されます。```hashed_password``` を直接扱うことがあってはいけません。

ユーザーの作成には、通常のストアコレクションを利用します:

```ruby
def index
  self.model = store._users.buffer
end
```

ユーザー作成時のエラーを表示するためには、[volt-fields](https://github.com/voltrb/volt-fields) を利用することができます。

## require_login

Volt::ModelController には ```require_login``` メソッドが用意されており、ユーザーがログインしているかをチェックし、ログインしていなければログインページにリダイレクトさせることができます。また、ログインのフラッシュメッセージを表示することもできます。

:require_login の before action を利用すれば、特定のアクションのみでログインを要求することが可能です。

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :require_login

    def index
    end
  end
end
```

require_loginにはカスタムメッセージを設定することが可能です。また、フラッシュメッセージを表示させたくない場合にはnilを指定してください。

```ruby
module Main
  class MainController < Volt::ModelController
    before_action do
      require_login('Login or else')
    end

    def index
    end
  end
end
```


で修正されましたt {{ file.mtime }}
