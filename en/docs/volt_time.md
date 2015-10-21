# VoltTime

Volt provides an optional time helper class, `VoltTime` that can be required into your Volt application in a model or controller.

```ruby
require lib/volt/helpers/time
```

The benefits of using VoltTime over the standard ruby Time class are:

* VoltTime always holds the time in the UTC timezone so that there is no need for conversions between timezone when using VoltTime

* VoltTime has consistent behaviour across Ruby and Opal. Opal (because of the limitations of JavaScript) can only store times in either 
UTC or the local timezone. Although VoltTime always stores 
the time in the UTC timezone it can also accept and display time in the 
local timezone.

* VoltTime comes with an number of useful calculations and support for durations.  

## Instantiating a VoltTime object

There are a number of ways of instantiating a new VoltTime.

To get a VoltTime holding the current time you can use either:

```ruby
t = VoltTime.new
# => 2015-10-21 18:30:00 UTC
```

or

```ruby
t = VoltTime.now
# => 2015-10-21 18:57:46 UTC
```

To get a VoltTime holding a specific time you can also use `VoltTime#new`. One main case for instantiating a VoltTime holding a specific 
time is to turn user input into a VoltTime. In this case you would normally expect the user to provide the time in 
their own timezone. 
To create a VoltTime holding this time you would use the `:local` symbol as the first parameter to `VoltTime#new`:

```ruby
t = VoltTime.new(:local, 2015, 10, 21, 11, 30, 00)
# => 2015-10-21 18:30:00 UTC
```

It is also possible to instantiate a VoltTime from a UTC time, using the `:utc` symbol as the first parameter.

```ruby
t = VoltTime.new(:utc, 2015, 10, 21, 11, 30, 00)
# => 2015-10-21 11:30:00 UTC
```

A VoltTime object can also be instantiated in a couple of other ways. First it can be created from the number of seconds past
the epoch (1 January 1970 00:00:00) like this:

```ruby
t = VoltTime.at(60)
# => 1970-01-01 00:01:00 UTC
```

The final method to instantiate a `VoltTime` is to create one from an existing `Time` object.

```ruby
tx = Time.now
# => 2015-10-21 12:16:32 -0700
t = VoltTime.from_time(tx)
# => 2015-10-21 19:16:32 UTC
```

## Comparisons

VoltTime offers the usual comparisons ``==`` and ``<==>` and these will compare a VoltTime with another VoltTime or a Time.

In addition, VoltTime also has a `#compare` method which checks if two VoltTime objects are within the same year, month (of a year), day (of a month and year), hour (of a day), minute (of an hour in a day) or second (of a minute in an hour of a day).

For example:

```ruby
t1 = VoltTime.new(:utc, 2015, 01, 01)
t2 = VoltTime.new(:utc, 2015, 01, 02)
t1.compare(t2, :year)
# => 0
t1.compare(t2, :day)
# => -1
```

The options for the second parameter in `VoltTime#compare` are `:year`, `:month`, `:day`, `:hour`, `:min` and `:sec`. The method returns `0` if the two VoltTime objects are equal to within the same 'accuracy', `1` (if `t1` in the example above is after `t2`) or `-1` (if `t1` is before `t2` in the example above).

## Calculations

VoltTime has the same kind of calcuation methods as Rails adds to Time.

| Method              | Description                                              |
|---------------------|----------------------------------------------------------|
| `#beginning_of_day` | Returns a VoltTime that is at time 00:00:00 for the date |
| `#end_of_day`       | Returns a VoltTime that is at time 00:00:00.999 for the date |
| `#middle_of_day` | Returns a VoltTime that is at time 12:00:00 for the date |
| `#seconds_since_midnight` | Returns the number of seconds since the beginning of the day |
| `#seconds_until_end_of_day` | Returns the number of seconds until the end of the day |
| `#ago(seconds)` | Takes a number of seconds as a parameter and returns a VoltTime that number of seconds ago |
| `#since(seconds)` | Takes a number of seconds as a parameter and returns a VoltTime that is the number of seconds into the future |
| `#beginning_of_hour` | Returns a VoltTime that is at the start of the hour |
| `#end_of_hour` | Returns a VoltTime that is at the end of the hour |
| `#beginning_of_minute` | Returns a VoltTime that is the beginning of the minute |
| `#end_of_minute` | Returns a VoltTime that is the end of the minute |
| `#all_day` | Returns a Range of VoltTime objects from the beginning to the end of the day |


