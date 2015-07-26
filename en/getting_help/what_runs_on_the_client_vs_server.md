# What runs on the client vs the server?

One confusing thing with frameworks that run on both the client and server is knowing what's running where.  To simplify things, we'll break down the different parts of app's and where they run.

## Controllers and Views

In volt, controllers, models, and views are accessable on both the client and server.  Typically however, **controllers** and **views** usually run on the client only.  In the future, they will run once on the server for an initial page request, to allow for faster loading.

## Models

Models run on both the client and the server.  When a model is changed, its validations/permissions are first run on the client side to check if the change is allowed.  If that succeeds, the change is sent to the server where the model is loaded again and changed on the server.  If the change passes the validations/permissions on the server, the model is saved and synced to other clients.  This means model code needs to be able to run on both sides.

## Tasks

Tasks are interesting.  They are primarially designed to allow the client side to call code on the server.  Thanks to Volt's syncing models, you can write most of your app so it runs on the client.  Running code on the client allows for fast reloading and sharing of data between actions.  However, there are many times when you might want to call server code from the client:

- **Security**: Some data needs to be processed without sending it to the client.
- **Bandwidth**: You want to process a large amount of data to create a small result.
- **Opal incompatible gems**: Some gems are not supported by Opal, these can be easily accessed through Tasks.

Tasks provide an asynchronus interface to all methods in a task instance.  All public task methods are accessable through a...

## Running code only on the client or the server

You can check if the code is running on the server or client with ```Volt.server?``` and ```Volt.client?```  Sometimes however you do not want code to be compiled to the client at all, in this case opal provides a nice way to not compile code in Opal.  You can do:

```ruby
if RUBY_PLATFORM != 'opal'
  ...
end
```

The nice thing with the above is it will completely remove the code and not send it to the client.  Keep in mind however that this does not work around ```require``` since opal does requires at compile time.

## Security

A common question is what do I have to do to secure my app.  The two places you need to worry about security are:
1) model permissions
2) tasks

### Model permissions

Model permissions determine how data can be changed.  They are run both on the client side and again on the server side when data is changed or read.  Unlike backend frameworks, data can be changed from the client side without you needing to build an API.  Adding [model permissions](docs/permissions.md) is a simple way to secure your data according to your business logic.  See the [permissions](docs/permissions.md) page for more details.  The user model comes with permissions setup out of the box.

### Tasks

Tasks are similar to controllers in backend frameworks, except they work at the method level instead of using http.  Any public methods on a Task call be called from the client using class level methods.  The arguments will be passed to the backend, then the return value from the method will be sent back to the client.  Arguments in methods to Tasks should be validated, since they can contain any data that can be serialized to JSON (and Time objects)  Models will still validate permissions when used inside of a Task.

### How to be secure

1) Make sure model permissions are in place and match how you want data read and manuipulated.
2) validate any data coming in as arguments to Tasks.  For example if you are requesting a remote API from a task, don't pass the whole URL in from the client side.  This would allow any url to be hit.  If you do pass the whole URL, check to make sure the domain/etc.. matches the url you want to hit.

Modified at {{ file.mtime }}
