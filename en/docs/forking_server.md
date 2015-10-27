# Forking Server

In development mode volt needs a way to reload your app code when code changes.  To detect changes, volt uses the ```listen``` gem to use the operating system's file change api to listen for changes.  When in development, and on linux or osx, and using MRI, Volt will run the app with the ForkingServer.  The ForkingServer runs behind the volt rack app which can be run with any Rack webserver (thin, puma, etc...)

## How it works

The idea behind the forking server is to load most of the dependencies for your app (ruby, volt, any gems), then fork off a seperate "child" process.  In the child process, your app code is loaded.  When a request comes into the parent server, it passes the request to the child process (currently using DRb.)  The child process answers the request and returns the result to the parent server which returns the results to the browser.

When you change code, the change is detected by the parent process.  If the change requires a code reload, the parent process will kill the child process.  The parent process will then fork itself again to create a new child process, which will load the app code again.

## Why it's fast

Since app code is small compared to ruby, volt, and all gem dependencies, the app can be booted very quickly after each change.  The heavy parts are already loaded.  Linux and OSX both support what's called "copy on write" forking.  This means that when a process forks, instead of making a separate copy of the original process's memory, the memory isn't copied until each block of memory is changed.  Since the majority of code memory in an app doesn't change, forking can be very fast.

## Advantages

One of the major advantages of forking over other code reloading strategies is that there are no artifacts of a code reload.  In rails for example, classes are unloaded by undefining the constant, then re-requiring the file.  For this to work requires files to follow an expected naming scheme.  The main problem however is when class loading has a side effect.  There can be times in ruby where side effects are not obvious (for example inheriting from a class can call ```#inherited```)  Using the forking server, your app always ends up in the same state as if it was booted from scratch (but in a fraction of the time)

## Other Platforms/Runtimes

The main limitation of the ForkingServer is that it does not work on Windows or Jruby because neither has fork.  We plan to introduct alternative reloading strategies to better support Windows and Jruby.
