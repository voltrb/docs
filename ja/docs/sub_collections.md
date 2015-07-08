## サブコレクション

他のコレクションと同じように、 モデルは ```store``` 上でネストすることができます:

```ruby
store._states.create({name: 'Montana'}).then do |montana|
  montana._cities << {name: 'Bozeman'}
  montana._cities << {name: 'Helena'}
end.then do
  store._states.create({name: 'Idaho'}).then do |idaho|
    idaho._cities << {name: 'Boise'}
    idaho._cities << {name: 'Twin Falls'}
  end
end
```

以下のモデルが作成されたことが確認できます:
```ruby
store._states
# => #<Volt::ArrayModel [#<Volt::Model id: "9fd5..66ff", name: "Montana">, #<Volt::Model id: "7d72..f4a1", name: "Idaho">]>
```
では、最初の state が含んでいる city が何か確認してみましょう。.first は promise を返すので、._cities の呼び出しも同様に promise を返します。

お```ruby
store._states.first._cities
# => #<Promise(70258435892520): #<Volt::ArrayModel [#<Volt::Model id: "41d5..b233", name: "Bozeman", state_id: "9fd53272ee1e4447c48866ff">, #<Volt::Model id: "f7ea..d07f", name: "Helena", state_id: "9fd53272ee1e4447c48866ff">]>>
```

先にモデルを作って、後からそれを挿入することも可能です:

```ruby
montana = Volt::Model.new({name: 'Montana'})

montana._cities.create({name: 'Bozeman'})
montana._cities.create({name: 'Helena'})

store._states.create(montana)
# => #<Promise(70297821780700): #<Volt::Model id: "84bd..b3be", name: "Montana">>
```
