# 自動モデル変換

## Hash -> Model

利便性のために、ある Model (モデル) の中にハッシュを入れた場合には、自動的に Model に変換されるようになっています。Model はハッシュに似ていますが、例えば永続化の機能を持っている点や、イベントをトリガできる点が異なります。

```ruby
user = Volt::Model.new
user._name = 'Ryan'
user._profile = {
  twitter: 'http://www.twitter.com/ryanstout',
  dribbble: 'http://dribbble.com/ryanstout'
}

user._name
# => "Ryan"
user._profile._twitter
# => "http://www.twitter.com/ryanstout"
user._profile.class
# => Volt::Model
```

Model をハッシュに戻したい場合には、`#to_h` を実行してください。

## Array -> ArrayModel

Model の中のアレイは自動的に ArrayModel のインスタンスに変換されます。ArrayModel は通常のアレイと同様に振る舞いますが、バックエンドのデータにバインドしたり、リアクティブなイベントを発生させたりできる点が異なります。

```ruby
model = Volt::Model.new
model._items << {name: 'item 1'}
model._items.class
# => Volt::ArrayModel

model._items[0].class
# => Volt::Model
model._items[0]
```


Volt::Model や Volt::ArrayModel を通常のハッシュに戻したい場合には、それぞれ .to_h と .to_a を実行してください。
(JavaScript のコードに渡すために) JavaScript のオブジェクトに変換したい場合には、`#to_n` (to native) を実行してください。

```ruby
user = Volt::Model.new
user._name = 'Ryan'
user._profile = {
  twitter: 'http://www.twitter.com/ryanstout',
  dribbble: 'http://dribbble.com/ryanstout'
}

user._profile.to_h
# => {twitter: 'http://www.twitter.com/ryanstout', dribbble: 'http://dribbble.com/ryanstout'}

items = Volt::ArrayModel.new([1,2,3,4])
# => #<Volt::ArrayModel:70226521081980 [1, 2, 3, 4]>

items.to_a
# => [1,2,3,4]
```

Volt::ArrayModel に対して .to_a を実行することで通常の配列を得ることができます。
