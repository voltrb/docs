# Rendering

When a user interacts with a web page, typically we want to do two things:

1. Change application state
2. Update the DOM

For example, when a user clicks to add a new todo item to a todo list, we might create an object to represent the todo item, then add an item to the list's DOM.  A lot of work needs to be done to make sure that the object and the DOM always stay in sync.

The idea of "reactive programming" can be used to simplify maintaining the DOM.  Instead of having event handlers that manage a model and manage the DOM, we have event handlers that update reactive data models.  In this style of programming, we describe our DOM layer in a declarative way and it automatically knows how to render and stay up-to-date with what's in our data models.

## State and Computations

Web applications center around maintaining state.  Many events can trigger changes to a state.  Page interactions like entering text into form elements, clicking a button or link, scrolling, etc. can all change the state of the app.  In the past, each page interaction event would manually change any state stored on a page.

In Volt, to simplify managing application state, all application state is kept in models that can optionally be persisted in different locations.  By centralizing the application state, we reduce the amount of complex code needed to update a page.  We can then build our page's html declaratively.  The relationships between the page and it's models are bound using function and method calls.

We want our DOM to automatically update when our model data changes.  To make this happen, Volt lets you "watch" any method/proc for updates.

## Computations

As a Volt user, you rarely need to use Computations and Dependencies directly.  Instead, you usually just interact with models and bindings.  Computations are used under the hood, and having a full understanding of what's going on is useful, but not required.

Lets take a look at Computations in practice.  We'll use the ```page``` collection as an example.  (You'll learn more about collections later.)

First, we setup a computation watch.  Computations are built by calling ```.watch!``` on a Proc.  Here we'll use the ruby 1.9 proc shorthand syntax ```-> { ... }```. It will run once, then run again each time the data in ```page._name``` changes.

```ruby
page._name = 'Ryan'
-> { puts page._name }.watch!
# => Ryan
page._name = 'Jimmy'
# => Jimmy
```

Each time ```page._name``` is assigned to a new value, the computation is run again.  A re-run of the computation will be triggered when any data accessed in the previous run is changed.  This lets us access data through methods and still have watches be re-triggered.

```ruby
page._first = 'Ryan'
page._last = 'Stout'

def lookup_name
  return "#{page._first} #{page._last}"
end

-> do
  puts lookup_name
end.watch!
# => Ryan Stout

page._first = 'Jimmy'
# => Jimmy Stout

page._last = 'Jones'
# => Jimmy Jones
```

When you call ```.watch!```, the return value is a ```Volt::Computation``` object.  In the event that you no longer want to receive updates, you can call ```.stop``` on the computation.

```ruby
page._name = 'Ryan'

comp = -> { puts page._name }.watch!
# => Ryan

page._name = 'Jimmy'
# => Jimmy

comp.stop

page._name = 'Jo'
# (nothing)
```

## Dependencies

As mentioned above, you will rarely use Dependencies directly, but having an understanding of them is useful. Let's take a brief look at them here.

TODO: Explain Dependencies


