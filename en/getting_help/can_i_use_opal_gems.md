# Can I use opal gems?

Yes.  Opal has its own way of including gems.  This usually means you need to require them gem its self in your MRI code before it will be added to the opal load path.

For example with opal/browser, you can simply add the following to config/app.rb

```ruby
require 'opal/browser'
```
