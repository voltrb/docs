# Permissions

By default Volt models can be read or edited by anyone, however it is easy to restrict how a model can be read or changed.  Volt's permissions API breaks this down in to four different actions: create, read, update, delete (or CRUD)

You specify permissions inside of a model class like so:

```ruby
class Todo < Volt::Model

    permissions do
      # .. permissions logic ..
    end
end
```

The permissions block is called anytime one of the CRUD actions happens on the model.  Inside of the permissiosn block, you can use ```allow``` and ```deny``` to restrict permissions.  If you call either without any arguments, then the entire action is blocked.  You can instead pass in a list of field names as arguments, then the action will only be blocked for those fields.

```ruby
class Todo < Volt::Model
  permissions do
    deny :label
  end
end
```

Once one allow is specified, all other fields will be denied.


```ruby
class Todo < Volt::Model
  permissions do
    allow :label, :complete
  end
end
```

^ only allow and complete would be allowed, all others would be blocked.
