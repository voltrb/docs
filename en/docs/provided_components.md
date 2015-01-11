## Provided Components

Volt provides a few components to make web developers' lives easier.

### Notices

Volt automatically places ```<:volt:notices />``` into views.  This component shows notices for the following:

1. flash messages
2. connection status (when a disconnect happens, lets the user know why and when a reconnect will be attempted)
3. page reloading notices (in development)

### Flash

As part of the notices component explained above, you can append messages to any collection on the flash model.

Each collection represents a different type of "flash".  Common examples are ```_notices```, ```_warnings```, and ```_errors```.  Using different collections allows you to change how the flash is displayed.  For example, you might want ```_notices``` and ```_errors``` to show with different colors.

```ruby
    flash._notices << "message to flash"
```

These messages will show for 5 seconds, then disappear (both from the screen and the collection).
