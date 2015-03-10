## Validations

Within a model class, you may setup validations.  Validations let you restrict the types of data that can be stored in a model.  Validations are mostly useful for the ```store``` collection, though they can be used elsewhere.

At the moment, we only have two validations implemented (length and presence).  A lot more are coming!

```ruby
    class Info < Volt::Model
      validate :name, length: 5
      validate :state, presence: true
    end
```

When calling save on a model with validations, the following occurs:

1. Client side validations are run; if they fail, the promise from ```save!``` is rejected with the error object.
2. The data is sent to the server where client- and server-side validations are both run on the server; any failures are returned and the promise is rejected on the front-end (with the error object)
    - re-running the validations on the server-side helps to make sure that no data can be saved that doesn't pass the validations.
3. If all validations pass, the data is saved to the database and the promise is resolved on the client.
4. The data is synced to all other clients.
