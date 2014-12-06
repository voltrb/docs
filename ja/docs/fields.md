# フィールド

モデルクラスを利用すると、アンダースコアのシンタックスではなく、明示的にモデルのフィールドを指定することができます。

```ruby
class Post < Volt::Model
  field :title
  field :body, String
end
```

フィールドには、オプションで型の制約を設定することが可能です。フィールドに対する参照や代入はメソッドを介して行います。

```ruby
new_post = Post.new(body: 'it was the best of times')

new_post.title = 'A Title'

new_post.title
# => 'A Title'

store._posts << new_post
```
