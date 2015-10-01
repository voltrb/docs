# Runners/Processes

When you have code you want to run out of the normal request cycle, you can do it one of two ways:

## 1) Runners

You can put code in lib for example at ```app/main/lib/some_runner.rb```, then you can run the code by doing the following command:

```bundle exec volt app/main/lib/some_runner.rb```

The runner command will load up the current app before running the code in the .rb file.

## 2) Boot the App

If you need to load the volt app inside of different context.  For example, using the [clockwork](https://github.com/tomykaira/clockwork) gem, or other gems that use their own command, you can boot the volt app at any time by doing:

```ruby
require 'volt/boot'
Volt.boot(Dir.pwd)
```

```Volt.boot``` takes a signle argument, the path to the volt app directory.  Be sure to run in ```bundle exec``` with the app Gemfile so that volt and its dependencies are loaded.
