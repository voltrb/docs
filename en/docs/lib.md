# Lib

**Note:** This section is still a work in progress.

Gems in the Gemfile are not automatically required in Volt.  This was a decision made for a few reasons.

1. It really really increases boot performance, especially on larger apps. (one of the biggest complaints I hear about rails) Component gems included in dependencies.rb will have the parts in app included by default.
2. It makes it so unused code doesn't get loaded.

Check out [5 reasons to avoid Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require) for more reasons.

If you really like having Gems auto-required, you can put the following at the start of your ```config/app.rb``` file.

```ruby
Bundler.setup
```
