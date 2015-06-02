# Can I use opal gems?

Yes.  Opal has its own way of including gems.  This usually means you need to require the gem itself in your MRI code before it will be added to the opal load path.

For example with opal/browser, you can simply add the following to config/app.rb

```ruby
require 'opal/browser'
```

Then in a controller where you want to use opal-browser, add the following to the top of the file:

```ruby
if RUBY_PLATFORM == 'opal'
  require 'browser'
end
```
