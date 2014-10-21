# Testing

** Testing is being reworked at the moment.
Volt provides rspec and capybara out of the box.  You can test directly against your models, controllers, etc... or you can do full integration tests via [Capybara](https://github.com/jnicklas/capybara).

To run Capybara tests, you need to specify a driver.  The following drivers are currently supported:

1. Phantom (via poltergeist)

```BROWSER=phantom bundle exec rspec```

2. Firefox

```BROWSER=firefox bundle exec rspec```

3. IE - coming soon

Chrome is not supported due to [this issue](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) with ChromeDriver.  Feel free to go [here](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) and pester the chromedriver team to fix it.
