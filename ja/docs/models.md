# モデル

多くのフレームワークでは、モデルというのはデータベースとの ORM で使われる単語ですが、Volt のモデルのコンセプトはそれとは少し異なっています。Volt において、モデルはデータを簡単に保存しておくために利用できるクラスを指します。モデルは "Volt::Persistor" を使って生成することもできます。これは、(データベースやローカルストレージ、URL パラメータなどに) データを永続化するための役割を持ちます。Persistor を使わずにモデルを生成した場合は、単純にクラスのインスタンスにデータを保持します。どのようにモデルを使うのか、まず見てみましょう。

モデルは Volt::Model のインスタンスです。まず、インスタンスを直接生成してみましょう。

```ruby
item = Volt::Model.new
item
# <Volt::Model {:id=>"beb492e2997ebd1365d3bf83"}>
```

Volt のモデルには ID 属性として自動的に [GUID](https://en.wikipedia.org/wiki/Globally_unique_identifier) が割り当てられます。モデルは、set/get プロパティを利用できるハッシュのようなものです。モデルのプロパティを扱う方法は2つあります。

- アンダースコア アクセサ
- フィールド

## アンダースコア アクセサ

First lets look at underscore accessors.  これは、明示的に事前に設定しておかなくても set/get プロパティを利用できるものです。

```ruby
item = Volt::Model.new
item._name = 'Ryan'
item._name
# => "Ryan"

item
# => <Volt::Model {:id=>"d8872b283c6dc1a7861e9baa", :name=>"Ryan"}>
```

Notice that we didn't have to setup the field name ahead of time.  アンダースコアをプロパティ名の前につけることで、モデルの set/get プロパティを利用することができます。(※これはハッシュの ```[:property]``` と同様です。詳細は [こちら](/getting_help/why_use_underscore_accessors_instead_of_[property].md) を参照してください)

アンダースコア アクセサは、実際に必要なフィールドを決定する前のプロトタイピングに利用することが多いです。

# フィールド

クラスでフィールドを利用するには、モデルクラスを作成します。モデルクラスは　Volt::Model を継承して、app/{コンポーネント}/models/model_name.rb に配置される必要があります。(※もし Volt を使うの初めてであれば、コンポーネントには「main」を指定してください) 新しいモデルを作るには以下のようにします:

```bash
bundle exec volt generate model Item
```

モデルクラスを作成したら、アンダースコア アクセサの代わりに、明示的にフィールドを設定することができます。

```ruby
class Post < Volt::Model
  field :title                              # 型制約なし
  field :body, String                       # string
  field :published, Volt::Boolean           # true または false
  field :count_or_details, [String, Fixnum] # String または Fixnum
  field :notes, String, allow_nil: true     # nil を許容する String フィールド
end
```

フィールドには、オプションで1つ以上の制約を設定することが可能です。もし代入される値が制約された型ではない場合 (そして、string -> int/float のように簡単にキャスト可能なものではない場合)、モデルはバリデーションエラーを発生させｔます。注意: Ruby には Boolean クラスが存在せず、Opal には TrueClass/FalseClass がありません。したがって、型制約で真偽値を指定したい場合には ```Volt::Boolean``` を使用してください。

フィールドを追加したら、モデルのインスタンスでプロパティ名のメソッドを実行することで read/assign が可能です (Ruby の getter)。プロパティは「プロパティ名 =」メソッドでセットできます。

```ruby
new_post = Post.new(body: 'it was the best of times')

new_post.title = 'A Title'

new_post.title
# => 'A Title'

store._posts << new_post
```

## コレクション

Volt のモデルはそれ自体では永続化機能が組み込まれていません。永続化を利用するためにはコレクションを利用する必要があります。Volt はデフォルトで多くのコレクションを組み込んでいます。その1つが ```page``` です。コンソール (またはコントローラー) で ```page``` を使うと、page コレクションへアクセスすることができます。

```ruby
page._name = 'Ryan'
page._name
# => 'Ryan'
```

コレクションはモデルのための永続化機能を持った根っこのモデルを提供します。「アンダースコア・メソッド」を実行した時は、属性が定義されていればその属性の値を、定義されていなければ```nil```を返します。

## ネスト

モデルはネストすることも可能です。

```ruby
page._setting = {}
page._setting._color = 'blue'
page._setting._color
# => 'blue'
```

空のハッシュをプロパティにアサインして、```page``` の ```setting``` プロパティでアクセス可能な別のモデルを作っています。```setting``` モデルは自身のプロパティを持つことができます。

プロパティにモデルをアサインせずにモデルをネストしたい場合は、```!``` (bang と発音します) メソッドが利用できます。

```ruby
page._setting!._color = 'blue'
page._setting._color
# => 'blue'

page
# => <PageRoot {:id=>"0df58b9f8b6b6f3404ea4d7b", :setting=><Volt::Model {:id=>"5ea3193e429c1f2ecba21bc5", :color=>"blue"}>}>
```

```._setting!``` は、プロパティがアサインされていなければ新しいモデルを作成して返します。(※これを "拡張 (expanding)" と呼びます )

# ArrayModel

Volt のモデルでは、複数形の名前を持ったプロパティは ```Volt::ArrayModel``` のインスタンスを返します。ArrayModel は通常のアレイと同じように振る舞います。要素の追加/削除は通常のアレイと同様のメソッド (```#<<```, ```push```, ```append```, ```delete```, ```delete_at```, etc...) で行うことができます。

```ruby
page._items
# #<Volt::ArrayModel []>

page._items << {name: 'Item 1'}

page._items
# #<Volt::ArrayModel [<Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>]>

page._items.size
# => 1

page._items[0]
# => <Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>
```
