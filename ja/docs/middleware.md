# ミドルウェア

Volt はデータベースとの通信やタスクに WebSocket を利用しますが、HttpController には Rack を利用して WebSocket のコネクションを設定しています。独自のミドルウェアを追加することが可能です。コンポーネントの config/initializers/boot.rb で、以下を設定することができます:

```ruby
Volt.current_app.middleware.use(SomeMiddleware)
```

```Volt.current_app.middleware``` は ```Rack::Builder``` のインスタンスのように振る舞う ```Volt::MiddlewareStack``` を返します。また、以下のメソッドをサポートしています:

- ```use```
- ```run```

(※ミドルウェアの順序を設定するためのメソッドが追加される予定です)
