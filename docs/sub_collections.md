## Sub Collections

Models can be nested on ```store```

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
    # #<ArrayModel:70129010999880 [<Model:70129010999460 {:name=>"Montana", :_id=>"e3aa44651ff2e705b8f8319e"}>, <Model:70128997554160 {:name=>"Montana", :_id=>"9aaf6d2519d654878c6e60c9"}>, <Model:70128997073860 {:name=>"Idaho", :_id=>"5238883482985760e4cb2341"}>, <Model:70128997554160 {:name=>"Montana", :_id=>"9aaf6d2519d654878c6e60c9"}>, <Model:70128997073860 {:name=>"Idaho", :_id=>"5238883482985760e4cb2341"}>]>
```

You can also create a Model first and then insert it.

```ruby
    montana = Model.new({name: 'Montana'})

    montana._cities << {name: 'Bozeman'}
    montana._cities << {name: 'Helena'}

    store._states << montana
```
