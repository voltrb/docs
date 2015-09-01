# Users

Users are a core component of most web apps.  To help standardize things, Volt builds the concept of users into the framework.

## Note

Volt's user features are still being worked on. The plan is to add [omniauth](https://github.com/intridea/omniauth) support to be able login through third party services.  Right now only an email or username/password option is provided.

## Working with Users

Volt ships with the [volt-user-tempates](https://github.com/voltrb/volt-user-templates) gem out of the box.  First, we'll see how to use users, then we'll talk about how to create your own signup and login pages.

```volt-user-templates``` provides signup and login templates that render via the default main route template.  Volt provides routes at ```/signup``` and ```/login``` in ```routes.rb```, or you can render the templates using a tag.  See the [volt-user-templates readme](https://github.com/voltrb/volt-user-templates) for more info.

You can access the current user model with ```Volt.current_user```.  This will return nil at first, then reactively update with the user once it is fetched from the server.  If you want to wait for the user to return, you can use ```Volt.fetch_current_user```, which will return a promise that resolves when the user is loaded, or resolve nil if the user is not logged in.

## Restricting Models

Volt provides helpers to ensure that models can only be modified by certain users.  See [permissions](#permissions) for more information.

## Logging In

You can log a user in with:

```ruby
Volt.login(login, password)
```

In the above, ```login``` can be either the username or email based on the config.  ```Volt.login``` returns a [promise](http://opalrb.org/blog/2014/05/07/promises-in-opal/) that resolves on a successful login, or fails with an error message on an unsuccessful login.

```ruby
Volt.login(email, password).then do
  # redirect on successful login
  go '/dashboard'
end.fail do |error|
  # login failed with an error
  flash._errors << error
end
```

## Logging Out

You can log a user out by calling:

```ruby
Volt.logout
```

This call returns immediately and triggers a change event on ```Volt.current_user```.

## Login as User

From a Task or HttpController , you can login as a user directly using:

```ruby
login_as(user)
```

Where user is a user instance.

## Creating Users

To see an example of creating users, see [volt-user-templates](https://github.com/voltrb/volt-user-templates).

Volt provides a ```Volt::User``` class that any model can inherit from.  By default, Volt provides a User model in ```app/main/models/user.rb```.

By default, ```Volt::User``` uses the ```email``` property as the login, however you can configure an app to use ```username``` instead.  To do this, in ```config/app.rb```, add:

```ruby
config.public.auth.use_username = true
```

```Volt::User``` provides validations on ```email``` or ```username```.  Passwords can be stored in the ```password``` property.  Passwords will be hashed using [bcrypt](https://github.com/codahale/bcrypt-ruby) and stored in ```hashed_password```.  You should not need to deal with ```hashed_password``` directly.

To create a user, you use the normal store collection:

```ruby
def index
  self.model = store._users.buffer
end
```

You can use [volt-fields](https://github.com/voltrb/volt-fields) to show any errors when creating a user.

## require_login

Volt::ModelController has a ```require_login``` method that will check if the user is logged in, and redirect to the login page if they are not.  It will also flash up a message to login.

You can require a logged in user for certain actions using the :require_login before action.

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :require_login

    def index
    end
  end
end
```

You can also pass a custom message to require_login, or nil if you don't want to flash a message:

```ruby
module Main
  class MainController < Volt::ModelController
    before_action do
      require_login('Login or else')
    end

    def index
    end
  end
end
```

