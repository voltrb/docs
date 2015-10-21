# VoltTime

Volt provides an optional time helper that can be required into your Volt application in a model or controller.

```ruby
require lib/volt/helpers/time
```

The benefits of using VoltTime over the standard ruby Time class are:

* VoltTime always holds the time in the UTC timezone so that there is no need for conversions between timezone when using VoltTime

* VoltTime has consistent behaviour across Ruby and Opal. Opal (because of the limitations of JavaScript) can only store times in either 
UTC or the local timezone, rather than in any timezone like Ruby Time. Although VoltTime always stores 
the time in the UTC timezone it can also accept and display time in the 
local timezone.

* VoltTime comes with an number of useful calculations and support for durations.  

## Instantiating a VoltTime object

There are a number of ways of instantiating a new VoltTime.

To get a VoltTime holding the current time you can use either:

```ruby
t = VoltTime.new
```

or

```ruby
t = VoltTime.now
```

To get a VoltTime holding a specific time you can also use `VoltTime#new`. One main case for instantiating a VoltTime holding a specific 
time is to turn user input into a VoltTime. In this case you would normally expect the user to provide the time in 
their own time zone. For example, if I am in the _Pacific Standard Time_ zone and I want to enter a time of 21 October 2015 at 11:30 am.
To create a VolTime holding this time you would use the `:local` symbol as the first parameter to `VoltTime#new`:

```ruby
t = VoltTime.new(:local, 2015, 10, 21, 11, 30, 00)
```

VoltTime converts this to UTC and holds it as `2015-10-21 18:30:00 UTC` bcause PST is 7 hours behind UTC in this case.

It is also possible to instantiate a VoltTime from a UTC time, using the `:utc` symbol as the first parameter.

```ruby
t = VoltTime.new(:utc, 2015, 10, 21, 11, 30, 00)
```

will create a VoltTime at `2015-10-21 11:30:00 UTC`.

A VoltTime object can also be instantiated in a couple of other ways. First it can be created from the number of seconds past
the epoch (1 January 1970 00:00:00) like this:

```ruby
t = VoltTime.at(60)
```

which creates a VoltTime holding `1970-01-01 00:01:00 UTC` which is 60 seconds after the epoch.

The final method to create a VoltTime is to create one from an existing Time object.

```ruby
tx = Time.now
t = VoltTime.from_time(tx)
```

The Time `tx` will be converted to UTC to be held in the VoltTime, `t`.



