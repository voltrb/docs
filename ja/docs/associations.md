# アソシエーション

Voltは階層的なモデル構造を提供しており、明示的に宣言することなくアクセスすることが可能です。しかし、外部IDを使って他のモデルとアソシエーションを構成したい場合もあるでしょう。Voltは規約として```_id``` という名前のフィールドを利用します。そして、モデル間のアソシエーションを構成するためのメソッドとして ```belongs_to``` と ```has_many``` を提供しています。

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
end
```

## has_many

```has_many``` メソッド使用することで、他のモデルのインスタンスで、その ```_id``` フィールドが現在のモデルを指しているものを見つけることができます。例えば、「person」インスタンスがあったとしましょう:

```ruby
person.addresses
# => [<Address ..>, <Address ..>, ...]
```

「person」に対して .addresses を実行すると、その「person」モデルのID (person_id を持ったすべての```addresses``` を見つけることができます。

```has_many``` アソシエーションはカーソルを返します。

## belongs_to

```belongs_to``` を使うと、モデルの親であるモデルを見つけることができます。「address」インスタンスの場合を考えてみましょう。

```ruby
address.person.then do |person|
  # => person is: <Person ...>
end
```

```belongs_to``` アソシエーションは関連付けられたモデルで解決するpromiseオブジェクトを返します。

