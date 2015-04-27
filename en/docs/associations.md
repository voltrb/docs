# Associations

Volt provides a nested model structure that can be accessed without any explicit declarations.  However often you may want to association other models using external id's.  Volt uses the ```_id``` field naming convention.  Volt provides a ```belongs_to``` and ```has_many``` method to associate models.

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
end
```

## Has Many

You can use ```has_many``` to lookup all instances of another model that have a ```_id``` field pointing to the current model.  For example if we had a person instance:

```ruby
person.addresses
# => [<Address ..>, <Address ..>, ...]
```

Calling .addresses on person would find all ```addresses``` with their person_id set to the id of the person model.

```has_many``` associations return a cursor.

## Belongs to

You can use ```belongs_to``` to lookup the parent of a model.  So if we had an instance of address:

```ruby
address.person.then do |person|
  # => person is: <Person ...>
end
```

```belongs_to``` associations return a promise that resolves with the associated model.

