# アソシエーション

Voltは階層的なモデル構造を提供しており、明示的に宣言することなくアクセスすることが可能です。しかし、外部IDを使って他のモデルとアソシエーションを構成したい場合もあるでしょう。Voltは規約として```_id``` という名前のフィールドを利用します。そして、モデル間のアソシエーションを構成するためのメソッドとして ```belongs_to```、```has_many``` 、そして ```has_one``` を提供しています。

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
  has_one :street
end

class Street < Volt::Model
  belongs_to :address
end
```

## Has Many

```has_many``` メソッドを使用することで、他のモデルのインスタンスで、その ```_id``` フィールドが現在のモデルを指しているものを見つけることができます。例えば、「person」インスタンスがあったとしましょう:

```ruby
person.addresses
# => #<Volt::ArrayModel [#<Address ..>, #<Address ..>, ...]>
```

「person」に対して .addresses を実行すると、その「person」モデルのID (person_id を持ったすべての```addresses``` を見つけることができます。

```has_many``` アソシエーションはカーソルを返します。

#### オプション

User モデルの has_many の2番目の引数として、以下のオプションを渡すことが可能です。

:collection - データベースのコレクション名と、モデルが返された際にロードされるべきクラス

:foreign_key - (デフォルトでは現在のクラス名 + "_id" となります) もし、```has_many :posts, foreign_key: :user_id``` としたときには、次のクエリとなります。```store.posts.where(user_id: self.id)```

:local_key - モデルのID。デフォルトでは ```self.id```もし、```has_many :posts, local_key: :user_system_id``` としたときには、次のクエリとなります。```store.posts.where(user_id: self.user_system_id)```

## Has One

モデルクラスで ```has_one``` を使用すると、別の1つのモデルとの関連を設定することができます。```has_one``` は引数に別のモデルの名前をシンボルとして受け取ります。```Address``` モデルで ```:street``` を渡した場合、同じ address_id を持った```Street``` モデルを検索します。

has_one に対しても has_many と同じオプションを指定可能です。

## Belongs to

```belongs_to``` を使うと、モデルの親であるモデルを見つけることができます。「address」インスタンスの場合を考えてみましょう。

```ruby
address.person.then do |person|
  # => person is: #<Person ...>
end
```

```belongs_to``` アソシエーションは関連付けられたモデルで解決するpromiseオブジェクトを返します。

#### オプション

Post モデルの belongs_to の2番目の引数として、以下のオプションを渡すことが可能です。

:collection - データベースのコレクション名と、モデルが返された際にロードされるべきクラス

:foreign_key - (モデルの belongs_to の対象のモデルのフィールド名。デフォルトでは :id) もし、```belongs_to :user, foreign_key: :user_system_id``` としたときには、次のクエリとなります。```store.users.where(user_system_id: self.user_id).first```

:local_key - モデルで、belongs_to の関連を見つけるために利用されるキー。デフォルトでは belongs_to のコレクション名 + "_id"もし、```belongs_to :user, local_key: :remote_user_id``` としたときには、次のクエリとなります。```store.users.where(user_id: self.remote_user_id).first```
