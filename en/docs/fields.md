# Fields

Once you have a model class you can specify fields on the model explicitly instead of using the underscore syntax.

```ruby
class Post < Volt::Model
  field :title
  field :body, String
end
```

Fields can optionally take a type restriction.  Once you add fields, they can be read and assigned with methods.

```ruby
new_post = Post.new(body: 'it was the best of times')

new_post.title = 'A Title'

new_post.title
# => 'A Title'

store._posts << new_post
```
