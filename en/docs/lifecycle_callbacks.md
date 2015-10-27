## Lifecycle Callbacks

Volt currently supports callbacks for the following serverside events:

### client_connect

This event fires whenever a client starts a session on your Volt application. An example of hooking into this event might look like this:
```ruby
Volt.current_app.on("client_connect") do
    # do something
end
```

### client_disconnect

This event fires whenever a client ends a session on your Volt application. An example of hooking into this event might look like this:
```ruby
Volt.current_app.on("client_disconnect") do
    # do something
end
```
### user_connect
This event fires whenever a user logs in or otherwise starts a session on your Volt application with a valid session cookie. An example of hooking into this event might look like this:
```ruby
Volt.current_app.on("user_connect") do |user_id|
    user = store.users.where(id: user_id).first.sync
    user._presence = "online"
    user._session_count += 1
    user._last_login = Time.now
end
```

### user_disconnect
This event fires whenever a user logs out, closes the browser window or otherwise navigates away from your application. You can hook into this event as follows:
```ruby
Volt.current_app.on("user_disconnect") do |user_id|
    user = store.users.where(id: user_id).first
    user._presence = "offline"
end
```

## Custom Events
Volt also supports the ability to trigger custom server-side events. This allows you to easily expose event hooks for component gems, for example. Wherever you need to trigger a callback, you can use the following:
```ruby
Volt.current_app.trigger!("custom_event_name", *args)
```

A user of your component can then hook into this event as follows:
```ruby
Volt.current_app.on("custom_event_name") do |*args|
    # do something with *args
end
```
Events do not need to take any arguments:
```ruby
Volt.current_app.trigger!("custom_event_name")

Volt.current_app.on("custom_event_name") do
    # do something
end
```