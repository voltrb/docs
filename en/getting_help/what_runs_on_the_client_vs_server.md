# What runs on the client vs the server?

One confusing thing with frameworks that run on both the client and server is knowing what's running where.  To simplify things, we'll break down the different parts of app's and where they run.

## Controllers, Models, and Views

In volt, controllers, models, and views are accessable on both the client and server.  Typically however, **controllers** and **views** usually run on the client only.  In the future, they will run once on the server for an initial page request, to allow for faster loading.

## Tasks

Tasks are interesting.  They are primarially designed to allow the client side to call code on the server.  Thanks to Volt's syncing models, you can write most of your app so it runs on the client.  Running code on the client allows for fast reloading and sharing of data between actions.  However, there are many times when you might want to call server code from the client:

- **Security**: Some data needs to be processed without sending it to the client.
- **Bandwidth**: You want to process a large amount of data to create a small result.
- **Opal incompatible gems**: Some gems are not supported by Opal, these can be easily accessed through Tasks.

Tasks provide an asynchronus interface to all methods in a task instance.  All public task methods are accessable through a...

TODO: complete
