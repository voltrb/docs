# Voltコマンド

Voltは、プロジェクトの管理やデータの操作に関する様々なコマンドを提供しています。

## new

新しいプロジェクトを作成する場合には、```volt new project_name``` を実行します。newコマンドは基本的なアプリケーションの構成を構築しますので、新規プロジェクトを作成する場合にはnewコマンドを利用することを推奨します。

注意: volt newは、実行時に```bundle exec```をつけない唯一のコマンドです。その他のコマンドはすべて ```bundle exec``` をつけて実行する必要があります。

## generate

generateコマンドは、スタブのコードを生成するためのコマンドです。

### model

```bundle exec volt generate model NAME COMPONENT```

NAME には生成したいモデルの名前を指定します。モデル名は単数形で指定してください。もし COMPONENT が指定されない場合は、```main``` コンポーネントが指定されたものとします。

例:

```bundle exec volt generate model item```

### component

```bundle exec volt generate component NAME```

コンポーネントジェネレーターが ```app``` 以下にコンポーネントを生成します。

例:

```bundle exec volt generate component blog```

### gem

```bundle exec volt generate gem NAME```

Gemはコンポーネントのgemのためのファイルを生成します。コンポーネントのgemは、複数のプロジェクトにまたがってコンポーネントを再利用することを容易にします。

### view

```bundle exec volt generate view NAME COMPONENT```

viewはVoltのビューのためのファイルを生成します。もし、対応するモデルコントローラーが存在しない場合は、同時に生成を行います。

オプションでコンポーネントを指定することも可能ですが、デフォルトでは`main`が指定されたものとします。

### task

```bundle exec volt generate task NAME COMPONENT```

TaskはVoltタスクを生成します。オプションでコンポーネントを指定することも可能ですが、デフォルトでは`main`が指定されたものとします。

### model controller

```bundle exec volt generate controller NAME COMPONENT```

ControllerはVoltのモデルコントローラーのファイルを生成します。オプションでコンポーネントを指定することも可能ですが、デフォルトでは`main`が指定されたものとします。

### http_controller

```bundle exec volt generate http_controller NAME COMPONENT```

ControllerはVoltのHTTPコントローラーのファイルを生成します。オプションでコンポーネントを指定することも可能ですが、デフォルトでは`main`が指定されたものとします。

## server

```bundle exec volt server```

サーバーを起動します。デフォルトのポートは3000です。

オプション:
1.  -p, [--port=the port the server should run on]
2.  -b, [--bind=the ip the server should bind to]

## precompile

TODO: finish docs for precompile

## runner

```bundle exec volt runner path/to/file.rb```

runnerは、Voltのenvironmentでコードを実行するため使用します。引数には、実行したいRubyファイルのパスを指定してください。

## drop_collection

TODO:...
