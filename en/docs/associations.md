# Associations

Volt provides a nested model structure that can be accessed without any explicit declarations.  However often you may want to association other models using external id's.  Volt uses the ```_id``` field naming convention.  Volt provides a ```belongs_to```, ```has_many```, and ```has_one``` methods to associate models.

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
  has_one :street
end

class Street < Volt::Model
end
```

## Has Many

You can use ```has_many``` to lookup all instances of another model that have a ```_id``` field pointing to the current model.  For example if we had a person instance:

```ruby
person.addresses
# => #<Volt::ArrayModel [#<Address ..>, #<Address ..>, ...]>
```

Calling .addresses on person would find all ```addresses``` with their person_id set to the id of the person model.

```has_many``` associations return a cursor.

## Has One

You can call ```has_one``` in a model class to setup an association to a single other model.  ```has_one``` takes a symbol for the name of the other model.  If we passed ```:street``` on an ```Address``` model, Volt will look for a ```Street``` model that has the address_id set to the current address's id.

## Belongs to

You can use ```belongs_to``` to lookup the parent of a model.  So if we had an instance of address:

```ruby
address.person.then do |person|
  # => person is: #<Person ...>
end
```

```belongs_to``` associations return a promise that resolves with the associated model.

