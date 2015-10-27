# Lib

Volt is a client and server framework. Gems exist for both client and server and many gems are not compatible with either client or server environment. This and other reasons (see below) means that volt does not automatically require all gems at startup.

### Gems for client and server

Use Gemfile and bundler as always. But as mentioned above, you just have to remember to **require** gems explicitly.
For gems that run on both client **and** server, ```config/app.rb``` is a good place for such a require statement.

### Client only gems

A growing list of gems exist for use in the browser. Opal gems are usually prefixed with opal-.
Opal-browser or opal-jquery are good examples, just like opal-pixi or opal-phantom, all of which use the browser or DOM API.

To use a gem in your code, say opal-browser, you must require it in a conditional block. The syntax to do so is below.

```ruby
if RUBY_PLATFORM == 'opal'
  require "browser"
end

```

alternatively you can use an initializer for the client, eg ```config/initializers/client/gems.rb```

```ruby
require "browser"
```

in which case you can omit the platform test.

#### Opal load path

For client-only gems, you also need to instruct opal where to find the sources for the gem. This can be done in ```config/dependencies.rb``` with

```ruby
Opal.use_gem("browser")
```

### Server only gems

On the other hand some gems may not work on the browser, eg opal will never support c extensions. Also gems used in Tasks should be loaded only on the server. It is good practice to avoid loading gems into the browser, as anything loaded into the client takes network bandwidth.

Similarly, you can require conditionally, eg:

```ruby
if RUBY_PLATFORM != 'opal'
  require "nokogiri"
end
```
or alternatively you can use an initializer for the server, eg ```config/initializers/server/gems.rb```

```ruby
require "nokogiri"
```

### Bundler setup

Gems in the Gemfile are not automatically required in Volt.  This was a decision made for a few reasons.

1. It really really increases boot performance, especially on larger apps. (one of the biggest complaints I hear about rails) Component gems included in dependencies.rb will have the parts in app included by default.
2. It makes it so unused code doesn't get loaded.
3. It is not possible to tell which gems are client-only.

Check out [5 reasons to avoid Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require) for more reasons.

If you really like having Gems auto-required, you can put the following at the start of your ```config/app.rb``` file.

```ruby
Bundler.setup
```
