# Validations

Within a model class, you can setup validations.  Validations let you restrict the types of data that can be stored in a model.  Validations are mostly useful for the ```store``` collection, though they can be used elsewhere.

At the moment, we have the following validations (with more on the way):

- length
- present
- email
- format
- numericality
- phone number
- unique

See [this folder](https://github.com/voltrb/volt/tree/master/lib/volt/models/validators) for more info on the validators.

```ruby
class Info < Volt::Model
  validate :name, length: 5
  validate :state, presence: true
end
```

When ```save!``` on a buffer with validations is called, the following occurs:

1. Client side validations are run; if they fail, the promise from ```save!``` is rejected with the error object.
2. The data is sent to the server where client- and server-side validations are both run on the server; any failures are returned and the promise is rejected on the front-end (with the error object)
    - re-running the validations on the server-side helps to make sure that no data can be saved that doesn't pass the validations.
3. If all validations pass, the data is saved to the database and the promise is resolved on the client.
4. The data is synced to all other clients.

## Custom Validations

You can create a one off custom validation by passing a block to validate:

```ruby
validate do
  if _name.present?
    {}
  else
    { name: ['must be present'] }
  end
end
```

The block should return a hash of errors.  Each key relates to an array of error messages for the field.  You can return multiple errors and they will be merged.

## Conditional Validations

You may wish to use an existing validator only in certain situations.  For example, you may have a blog post that has a publish_date that should be set, but only when the post is published.  You can use any validator within a ```validations``` block (notice the plural).

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
***Note: the Boolean type is currently not supported. Support for types other than String and Numeric is forthcoming.***

You can also specify that the validation should only happen on create or update:

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
***Note: the Boolean type is currently not supported. Support for types other than String and Numeric is forthcoming.***

Lastly, ```validations``` passes in :create or :update based on the state.

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

## Custom Validators

TODO: Document custom validator classes
