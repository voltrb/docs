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
## Permission Logic

The permissions block is called anytime one of the CRUD actions happens on the model.  Inside of the permissiosn block, you can use ```allow``` and ```deny``` to restrict permissions  If you call either without any arguments, then the entire action is blocked.  You can instead pass in a list of field names as arguments, then the action will only be blocked for those fields.  When run, ```self``` inside of the permission block will be the current model.

```ruby
class Todo < Volt::Model
  permissions do
    deny :label
  end
end
```

If the last value in a permissions block (the implicit return) is a Promise, the permissions block will resolve the permissions block before continuing.  (So you can query other models inside of permissions blocks, and use .then to return a new promise.

```ruby
class Todo < Volt::Model
  permissions do
    # Volt.current_user returns a promsie that resolves the current user, we
    # then return a new promise that checks the admin state and denies unless
    # the user is an admin.
    Volt.current_user.then do |user|
      deny unless user.admin?
    end
  end
end

```

## Own by User

You can use the ```own_by_user``` method to automatically assign the ```user_id``` field to the logged in user when a model is created (See [Users](http://docs.voltframework.com/en/docs/users.html) for more info)  It will also setup a belongs_to :user (or optionally another key passed in for the ```user_id```)

If a model is owned by the user, you can check if the currently logged in user is the owner in a permissions block by calling ```.owner?```  Owner will return true if the current user is the owner.

```ruby
class Todo < Volt::Model
  own_by_user

  permissions do
    deny unless owner?
  end
end
```

^ The above would prevent anyone besides the owner from reading, creating, updating, or deleting this model.  (```.owner?``` returns true in create because ```own_by_user``` will have already assigned the ```user_id````)

### Allow vs Deny

Once one allow is specified, all other fields will be denied.  Deny's override allow's.

```ruby
class Todo < Volt::Model
  permissions do
    allow :label, :complete
  end
end
```

^ only label and complete would be allowed, all others would be blocked.  Using ```permission``` without any arguments will setup permissions for all CRUD operations (create, read, update, delete)  To restrict the permissions to only certain actions, you can pass in symbol's for each action as arguments to the ```permissions``` method.  You can also specify multiple permission blocks.

```ruby
class Todo < Volt::Model
  permissions(:create, :update) do
    deny :notes, :secret_notes unless owner?
  end

  permissions(:read) do
    deny :secret_notes unless owner?
  end

  permissions(:delete) do
    deny unless owner?
  end
end
```

^ The above would allow only the owner to change ```notes``` and ```secret_notes```, but anyone can change the other fields.  Only the owner could read ```secret_notes``` (while all other fields would be able to be read by anyone).  And only the owner could delete the model.

### Passing in the action

You can also pass an action argument to the permission block.  This will be a symbol representing the current action that is running.

```ruby
class Todo < Volt::Model
  permissions(:read, :update) do |action|
    if action == :read
        allow
    else
        deny unless owner?
    end
  end
end
```

### Skipping Permissions

Sometimes rather than setting up complex logic in permissions, you can simply deny changes, then only do changes from a task.  For example, if you wanted to set an ```admin``` flag on the user model.  You could simply deny updates to ```admin``` and then manually set admin by skipping permissions.

```ruby
class User < Volt::User
  permissions(:create, :update) do
    # make it so no one can update without skipping permissions
    deny :admin
  end
end
```

You can skip permissions by running ```Volt.skip_permissions``` and passing it a block.  ```skip_permissions``` can only be run on the server, for obvious reasons.

```ruby
Volt.skip_permissions do
  # Running without permission checks.
  # Set admin
  user._admin = true
end
```
### Wrapping Up

The permissions API attempts to provide a simple way to define who can do what to your app's data.  You can put any logic inside of the permissions blocks

