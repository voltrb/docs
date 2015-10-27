# バリデーション

モデルのクラスにはバリデーションを設定することが可能です。バリデーションによって、モデルに保存することができるデータの種類を制限することができます。特にバリデーションが有効なのは ```store``` コレクションに対してですが、他でも利用することができます。

現在のところ、以下のバリデーションが実装されています (更に追加される予定です)。

- length
- present
- email
- format
- numericality
- phone number
- unique
- type

より詳細な内容については、[このフォルダー](https://github.com/voltrb/volt/tree/master/lib/volt/models/validators) を参照してください。

```ruby
class Info < Volt::Model
  validate :name, length: 5
  validate :state, presence: true
end
```

バリデーションがある場合、ここでバッファに対して ```save!``` を実行すると、以下のようになります:

1. クライアントサイトでバリデーションが実行されます。もしバリデーションがエラーになった場合、```save!``` の結果の promise がエラーオブジェクトを伴って reject されます。
2. データはサーバーに送られ、クライアントサイドとサーバーサイドのバリデーションがサーバー上で実行されます。すべてのエラーが返され、promise はフロントエンドで (エラーオブジェクトを伴って) reject されます。
    - バリデーションがサーバーサイドでも再度実行されることで、バリデーションにパスしないデータが保存されてしまうことを確実に回避します。
3. すべてのバリデーションにパスすると、データはデータベースに保存され、promise はクライアント上で resolve されます。
4. データが他のすべてのクライアントと同期されます。

## カスタムバリデーション

バリデートのためのブロックを渡すことで、カスタムのバリデーションを設定することができます。

```ruby
validate do
  if _name.present?
    {}
  else
    { name: ['must be present'] }
  end
end
```

ブロックはエラーのハッシュを返す必要があります。キーはそれぞれ、フィールドのエラーメッセージの配列に対応します。複数のエラーを返すことも可能で、その場合、それらのエラーはマージされます。

## 条件バリデーション

特定の状況でのみバリデータを使いたい、というケースがあると思います。例えば、blog のポストがあったとき、そのポストが publish されている場合に限り、publish_date というデータが必ず設定されている必要があるといった場合です。```validations``` ブロックの内部では、自由にバリデータを利用することができます (複数形であることに注意)。

```ruby
class Post < Volt::Model
  field :title, String
  field :published, Boolean
  field :publish_date

  validate :title, length: 5

  validations do
    if published
      validate :publish_date, presence: true
    end
  end
end
```
***注意: Boolean 型は現在サポートされていません。String や Numeric 以外の型のサポートも追加される予定です***

また、create/update の場合にのみバリデーションを実行したい場合は以下のようにします。

```ruby
class Post < Volt::Model
  field :published, Boolean
  field :publish_date

  validations(:update) do
    if _published
      validate :publish_date, presence: true
    end
  end
end
```
***注意: Boolean 型は現在サポートされていません。String や Numeric 以外の型のサポートも追加される予定です***

```validations``` に :create または :update を状態に応じて渡すことも可能です

```ruby
class Post < Volt::Model
  ...

  validations do |action|
    if action == :update && _published
      validate :publish_date, presence: true
    end
  end
end
```

## カスタムバリデーター

TODO: Document custom validator classes
