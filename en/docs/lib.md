# Lib

Volt is a client and server framework. Gems exist for both client and server and many gems are not compatible with either client or server environment. This and other reasons (see below) mean that volt does not automatically require all gems at startup.

### Gems for client and server

Use Gemfile and bundler as always. But as mentioned above, you just have to remember to **require** them and eg. ```config/app.rb``` is a good place.

### Client only gems

A growing list of gems exist for use in the browser. Off course opal comes to mind, though that may still be run on any javascript vm.

Opal-browser or opal-jquery are good examples, just like opal-pixi or opal-phantom, which all use the browser or dom api.

To use a gem, say opal-browser in your code you must require it in a conditional block. The syntax to do so is below.

```ruby
if RUBY_PLATFORM == 'opal'
  require "browser"
end

```

### Server only gems

On the other hand some gems may not work on the browser. Opal is still young, and will off course never support c extensions. Also gems used in Tasks should be loaded only on the server as anything loaded into the client takes network bandwidth.

The way to do this is much the same as above, just the test is reverse.

```ruby
if RUBY_PLATFORM != 'opal'
  require "browser"
end
```

### Bundler setup

Gems in the Gemfile are not automatically required in Volt.  This was a decision made for a few reasons.

1. It really really increases boot performance, especially on larger apps. (one of the biggest complaints I hear about rails) Component gems included in dependencies.rb will have the parts in app included by default.
2. It makes it so unused code doesn't get loaded.
3. It is not possible to tell which gems are client only.

Check out [5 reasons to avoid Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require) for more reasons.

If you really like having Gems auto-required, you can put the following at the start of your ```config/app.rb``` file.

```ruby
Bundler.setup
```
