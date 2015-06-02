## Sub Collections

Like other collections, models can be nested on ```store```:

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

Then we can see the models we created:
```ruby
store._states
# => #<Volt::ArrayModel [#<Volt::Model id: "9fd5..66ff", name: "Montana">, #<Volt::Model id: "7d72..f4a1", name: "Idaho">]>
```
Next we can check our first state to see what cities it contains.  Since .first reutrns a promise, calling ._cities on it will also return a promise.

```ruby
store._states.first._cities
# => #<Promise(70258435892520): #<Volt::ArrayModel [#<Volt::Model id: "41d5..b233", name: "Bozeman", state_id: "9fd53272ee1e4447c48866ff">, #<Volt::Model id: "f7ea..d07f", name: "Helena", state_id: "9fd53272ee1e4447c48866ff">]>>
```

You can also create a Model first and then insert it:

```ruby
montana = Volt::Model.new({name: 'Montana'})

montana._cities.create({name: 'Bozeman'})
montana._cities.create({name: 'Helena'})

store._states.create(montana)
# => #<Promise(70297821780700): #<Volt::Model id: "84bd..b3be", name: "Montana">>
```
