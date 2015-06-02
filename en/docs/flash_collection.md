# Flash Collection

The flash collection lets you easily display information to the user on the client side.  Flash contains four (default) ArrayModel's, ```successes```, ```notices```, ```warnings```, and ```errors```.  When these collections are appended to, the message will be displayed in a div with the classes of ```"alert alert-{{ ..collection name.. }}"```

### Example

```ruby
flash._successes << "Your data has been saved"
```

```ruby
flash._errors << "Unable to save because you're not on the internet"
```

Strings added to any subcollection on flash will be removed after 5 seconds.  By default the flash message can be clicked to clear.

# Local Store Collection

The ```local_store``` collection persists its data in the browser's local store.

# Cookies Collection

The ```cookies``` collection stores data in a browser cookie.  Each assigned property gets saved to a cookie of the same name:

```ruby
cookies._user_id = 520

puts cookie._user_id
# => "520"

cookies.delete(:user_id)
```

Values in the cookie collection are converted to strings.  Adding expiration and other options are still on our todo list.  Right now cookies default to a 1 year expiration.


