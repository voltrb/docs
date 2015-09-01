# Associations

Volt provides a nested model structure that can be accessed without any explicit declarations.  However often you may want to associate other models using external id's.  Volt uses the ```_id``` field naming convention.  Volt provides a ```belongs_to```, ```has_many```, and ```has_one``` methods to associate models.

```ruby
class Person < Volt::Model
  has_many :addresses
end

class Address < Volt::Model
  belongs_to :person
  has_one :street
end

class Street < Volt::Model
  belongs_to :address
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

#### Options

You can pass the following options as the 2nd argument to has_many on a User model.

:collection - the name of the collection in the database, and the class that should be loaded when the models are returned

:foreign_key - (defaults to the current class name + "_id")  If you did: ```has_many :posts, foreign_key: :user_id```, it would do the following query: ```store.posts.where(user_id: self.id)```

:local_key - the id of the model, defaults to ```self.id```.  If you did: ```has_many :posts, local_key: :user_system_id``` it would do the following query:
```store.posts.where(user_id: self.user_system_id)```

## Has One

You can call ```has_one``` in a model class to setup an association to a single other model.  ```has_one``` takes a symbol for the name of the other model.  If we passed ```:street``` on an ```Address``` model, Volt will look for a ```Street``` model that has the address_id set to the current address's id.

Has one takes the same options as has_many.

## Belongs to

You can use ```belongs_to``` to lookup the parent of a model.  So if we had an instance of address:

```ruby
address.person.then do |person|
  # => person is: #<Person ...>
end
```

```belongs_to``` associations return a promise that resolves with the associated model.

#### Options

You can pass the following options as the 2nd argument to belongs_to on a Post model.

:collection - he name of the collection in the database, and the class that should be loaded when the models are returned

:foreign_key - (the field name on the model that this model belongs to, defaults to :id)  If you did: ```belongs_to :user, foreign_key: :user_system_id``` it would do the following query:
```store.users.where(user_system_id: self.user_id).first```

:local_key - the key on this model that should be used to lookup the belongs_to association - defaults to the belongs_to collection name + "_id".  If you did: ```belongs_to :user, local_key: :remote_user_id``` it would do the following query:
```store.users.where(user_id: self.remote_user_id).first```
