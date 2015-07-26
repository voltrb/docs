# Testing

Volt uses rspec by default for testing, however you can change out rspec for another testing framework by removing the rspec related gems in your projects Gemfile.  Most generators generate stub specs to help you get started.

The convention in a Volt project is to mirror your app directory inside of spec, so that each component gets its own folder inside of specs.  If you ```require 'spec-helper'``` in your spec file, you can run ```bundle exec rspec``` to run all tests, or you can include the path to a specific spec.  (Note: Volt does not use rake out of the box, so specs are normally run with rspec directly)

# Helpers

Volt provides methods inside of specs to access the ```page``` and ```store``` collection.  Due to a naming conflict with capybara, the method to access ```page``` inside of rspec is ```the_page``` (we're working on a way around the conflict).

You can access ```store``` by calling ```store``` in a spec.  If ```store``` is called, after the spec runs, the database will be cleared.  This makes it so no work needs to be done in the database per spec, except when the store is actually used.

# Integration Specs

Volt provides rspec and capybara out of the box.  You can test directly against your models, controllers, etc... or you can do full integration tests via [Capybara](https://github.com/jnicklas/capybara).

To make a spec run in capybara, simply add ```type: :feature``` to a description block:

```ruby
describe "browser specs", type: :feature do
  it ...
end
```

The integration tests don't run by default, to run Capybara tests, you need to specify a driver.  The following drivers are currently supported:

1. Phantom (via poltergeist)

```BROWSER=phantom bundle exec rspec```

2. Firefox

```BROWSER=firefox bundle exec rspec```

3. IE - coming soon

Chrome is not supported due to [this issue](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) with ChromeDriver.  Feel free to go [here](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) and pester the chromedriver team to fix it.

Modified at {{ file.mtime }}
