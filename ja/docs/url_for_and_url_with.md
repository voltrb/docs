# url_for と url_with

ルートの設定を利用して URL を生成したい場合には、```url_for``` または ```url_with``` を使用します。

## url_for

```url_for``` はパラメータ (params) のハッシュを引数にとり、ルートの設定 (と渡されたパラメータ) にしたがって URL を返します。

以下の例は、クエリストリングに ```?page=``` を与えたリンクの例です。この例では todos というコントローラーのルート設定にしたがいます。

```ruby
url_for(controller: 'todos', page: 5)
# => 'http://localhost:3000/todos?page=5'
```

## url_with

```url_with``` は ```url_for``` と似ていますが、現在のパラメータ (params) とマージされる点が異なります。以下の例では、パラメータが ```{controller: 'todos'}``` であるとして URL を返します。

```ruby
url_with(page: 5)
# => 'http://localhost:3000/todos?page=5'
```

url_for はコントローラーのメソッドなので、ビューからもアクセスすることが可能です。

```html
<a href="{{ url_with(page: 5) }}">page 5</a>
```
