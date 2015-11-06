# VoltTime

Volt provides an optional time class, `VoltTime` that can be required into your Volt application in a model or controller.

```ruby
require 'volt/helpers/time'
```

The key feature of VoltTime is that it always holds the time in the UTC timezone.

It also has consistent behaviour across Ruby and Opal. Opal (because of the limitations of JavaScript) can only store times in either 
UTC or the local timezone. Although VoltTime always stores 
the time in the UTC timezone it can also accept and display time in the client in the 
local timezone.

VoltTime comes with an number of useful calculations and support for durations.  

Almost all methods that are available in Time call be called on VoltTime.

Much of the functionality of VoltTime was inspired, copied and amended from Rails ActiveSupport.

## Initializing a VoltTime object

There are a number of ways of initializing a new VoltTime.

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

To get a VoltTime holding a specific time you can also use `VoltTime#new`. One main case for initializing  a VoltTime holding a specific 
time is to turn user input into a VoltTime. In this case you would normally expect the user to provide the time in 
their own timezone. 
To create a VoltTime holding this time you would use the `:local` symbol as the first parameter to `VoltTime#new`:

```ruby
t = VoltTime.new(:local, 2015, 10, 21, 11, 30, 00)
# => 2015-10-21 18:30:00 UTC
```

It is also possible to initialize a VoltTime from a UTC time, using the `:utc` symbol as the first parameter.

```ruby
t = VoltTime.new(:utc, 2015, 10, 21, 11, 30, 00)
# => 2015-10-21 11:30:00 UTC
```

A VoltTime object can also be initialized in a couple of other ways. First it can be created from the number of seconds past
the epoch (1 January 1970 00:00:00) like this:

```ruby
t = VoltTime.at(60)
# => 1970-01-01 00:01:00 UTC
```

And you can create a `VoltTime` from an existing `Time` object:

```ruby
tx = Time.now
# => 2015-10-21 12:16:32 -0700

t = VoltTime.from_time(tx)
# => 2015-10-21 19:16:32 UTC
```

## Comparisons

VoltTime offers the usual comparisons ``==`` and `<=>` and these will compare a VoltTime with another VoltTime or a Time.

In addition, VoltTime also has `#compare` and `#compare?`  methods which check if two VoltTime objects are within the same year, month (of a year), day (of a month and year), hour (of a day), minute (of an hour in a day) or second (of a minute in an hour of a day).

For example:

```ruby
t1 = VoltTime.new(:utc, 2015, 01, 01)
t2 = VoltTime.new(:utc, 2015, 01, 02)

t1.compare(t2, :year)
# => 0

t1.compare?(t2, :year)
# => true

t1.compare(t2, :day)
# => -1

t1.compare?(t2, :day)
# => false
```

The second parameter specifies the "accuracy" of the comparison and can be `:year`, `:month`, `:day`, `:hour`, `:min` or `:sec`. 
The `#compare?` method returns `true` if the two times are equal to within the given accuracy.
The `#compare`  method returns `0` if the two VoltTime objects are equal to within the given accuracy, `1` (if `t1` in the example above is after `t2`) or `-1` (if `t1` is before `t2` in the example above).

## Calculations

VoltTime supports the addition and subration of seconds with a VoltTime to return a VoltTime. 
It is also possible to subtract two VoltTime objects to return the number of seconds between them.

```ruby
VoltTime.at(0) + 60
# => 1970-01-01 00:01:00 UTC

VoltTime.at(60) - 60
# => 1970-01-01 00:00:00 UTC

VoltTime.at(60) - VoltTime.at(0)
# => 60.0
```

VoltTime also has the same kind of calcuation methods as ActiveSupport adds to Time. These calculations work in Ruby and Opal.

| Method              | Description                                              |
|---------------------|----------------------------------------------------------|
| `#beginning_of_hour` | Returns a VoltTime that is at the start of the hour |
| `#end_of_hour` | Returns a VoltTime that is at the end of the hour |
| `#beginning_of_minute` | Returns a VoltTime that is the beginning of the minute |
| `#end_of_minute` | Returns a VoltTime that is the end of the minute |
| `#ago(seconds)` | Takes a number of seconds as a parameter and returns a VoltTime that number of seconds ago |
| `#since(seconds)` | Takes a number of seconds as a parameter and returns a VoltTime that is the number of seconds into the future |

### Local calculations

In client code (i.e. Opal code), there are also calculations that are based on the user's local time. 
If you try and use these methods in Ruby on the server they throw an "unknown method" exception since the local timezone setting on the server is unlikely to be relevant. 


| Method              | Description                                              |
|---------------------|----------------------------------------------------------|
| `#local_beginning_of_day` | Returns a VoltTime that is at the start of the local day |
| `#local_end_of_day`       | Returns a VoltTime that is at the end of the local day |
| `#local_middle_of_day` | Returns a VoltTime that is at midday of the local day |
| `#local_seconds_since_midnight` | Returns the number of seconds since the beginning of the local day |
| `#local_seconds_until_end_of_day` | Returns the number of seconds until the end of the local day |
| `#local_all_day` | Returns a Range of VoltTime objects from the beginning to the end of the local day |

For example in the Pacific timezone:

```ruby
VoltTime.at(0).local_beginning_of_day
# => 1969-12-31 08:00:00 UTC

VoltTime.at(0).local_end_of_day
# => 1970-01-01 07:59:59 UTC

VoltTime.at(0).local_middle_of_day
# => 1969-12-31 20:00:00 UTC

VoltTime.at(0).local_all_day
# => 1969-12-31 08:00:00 UTC..1970-01-01 07:59:59 UTC
```

### UTC calculations

Similar calculations are available which give the result for the UTC timezone which can be used in Ruby and
Opal:


| Method              | Description                                              |
|---------------------|----------------------------------------------------------|
| `#beginning_of_day` | Returns a VoltTime that is at the start of the UTC day |
| `#end_of_day`       | Returns a VoltTime that is at time end of the UTC day |
| `#middle_of_day` | Returns a VoltTime that is at UTC midday of the day |
| `#seconds_since_midnight` | Returns the number of seconds since the beginning of the UTC day |
| `#seconds_until_end_of_day` | Returns the number of seconds until the end of the UTC day |
| `#all_day` | Returns a Range of VoltTime objects from the beginning to the end of the UTC day |

### Durations

Support for durations is included with VoltTime which allow calculations on VoltTime. A duration is created by
calling a duration method on a number, for example:

```ruby
3.months
=> 3 months
```

The duration methods support are:

* `#second` and `#seconds`
* `#minute` and `#minutes`
* `#hour` and `#hours`
* `#day` and `#days`
* `#week` and `#weeks`
* `#fortnight` and `#fortnights`
* `#month` and `#months`
* `#year` and `#years`

Durations can be added together:

```ruby
1.year + 3.months + 23.days
=> 1 year, 3 months and 23 days
```

They can also be compared:

```ruby
7.days == 1.week
# => true

30.days == 1.month
# => true
```

Note that although a month duration is assumed to be 30 days, for the calculations on VoltTime that follow, a month is treated as a calendar month.

Calculations on VoltTime can be done with durations. Durations can be added to or substracted from a VoltTime (note that months are treated
as calendar months):

```ruby
VoltTime.at(0) + 1.month
# => 1970-02-01 00:00:00 UTC

VoltTime.at(0) - 1.month
# => 1969-12-01 00:00:00 UTC
```

The methods `#ago` and `#from_now` are called without parameters to calculate a new VoltTime from
the time now. For example (note that months are treated as calender months):

```ruby
2.weeks.ago
#  => 2015-10-10 21:58:50 UTC

1.month.from_now
# => 2015-11-24 21:58:30 UTC
```

The methods `#since` and `#until` take a VoltTime as a parameter and calculate the VoltTime before or after this 
(note that months are treated as calendar months):

```ruby
1.month.since(VoltTime.at(0))
# => 1970-02-01 00:00:00 UTC

2.weeks.until(VoltTime.at(0))
# => 1969-12-18 00:00:00 UTC
```

## Converting to a Ruby `Time`

There are a number of methods on VoltTime that will return a Ruby `Time`:

* `#getlocal`
* `#localtime`
* `#to_time`

For example:

```ruby
t = VoltTime.new
# => 2015-10-24 22:08:40 UTC
volt(main)> t.to_time
# => 2015-10-24 15:08:40 -0700
```



## Formatted strings

VoltTime has many of the same output methods as Time which can be used in Opal and Ruby:

* `#inspect`
* `#to_s`
* `#asctime`
* `#ctime`
* `#strftime(string)`

See the [Ruby documentation](http://ruby-doc.org/core-2.2.0/Time.html#method-i-strftime) for details of the formatting options for `#strftime`.

### Local formatted string

VoltTime also has a number of methods for outputting the local time as string. These are only available in client (i.e Opal) code; in Ruby they will throw an "method not found" exception.

* `#local_to_s`
* `#local_asctime`
* `#local_ctime`
* `#local_strftime(string)`

The formating options for `#local_strftime` are the same as for `#strftime`.

For example in the Pacific timezone:

```ruby
VoltTime.at(0).local_to_s
# => "1969-12-31 16:00:00 -0800"

VoltTime.at(0).local_asctime
# => "Wed Dec 31 16:00:00 1969"

VoltTime.at(0).local_strftime("%Y %m %d")
# => "1969 12 31"

VoltTime.at(0).local_ctime
# => "Wed Dec 31 16:00:00 1969"
```


## Timezone information

VoltTime has methods that will give information about the local timezone.

There are class methods, `::current_zone` and `::current_offset` which return the current local timezone and the current local offset from UTC in seconds.

```ruby
VoltTime.current_zone
# => "PDT"

VoltTime.current_offset/60/60
# => -7
```

The instance method `#local_offset` gives the offset from UTC in seconds for the VoltTime in the local timezone.

```ruby
VoltTime.at(0).local_offset/60/60
# => -8
```
