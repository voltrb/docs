## サブコレクション

モデルは ```store``` 上でネストすることができます。

```ruby
    store._states << {name: 'Montana'}
    montana = store._states[0]

    montana._cities << {name: 'Bozeman'}
    montana._cities << {name: 'Helena'}

    store._states << {name: 'Idaho'}
    idaho = store._states[1]

    idaho._cities << {name: 'Boise'}
    idaho._cities << {name: 'Twin Falls'}

    store._states
    # #<Volt::ArrayModel:70129010999880 [<Volt::Model:70129010999460 {:name=>"Montana", :_id=>"e3aa44651ff2e705b8f8319e"}>, <Volt::Model:70128997554160 {:name=>"Montana", :_id=>"9aaf6d2519d654878c6e60c9"}>, <Volt::Model:70128997073860 {:name=>"Idaho", :_id=>"5238883482985760e4cb2341"}>, <Volt::Model:70128997554160 {:name=>"Montana", :_id=>"9aaf6d2519d654878c6e60c9"}>, <Volt::Model:70128997073860 {:name=>"Idaho", :_id=>"5238883482985760e4cb2341"}>]>
```

先にモデルを作って、後からそれを挿入することも可能です。

```ruby
    montana = Model.new({name: 'Montana'})

    montana._cities << {name: 'Bozeman'}
    montana._cities << {name: 'Helena'}

    store._states << montana
```
