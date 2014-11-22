# Flash Collection

The flash collection lets you easily display information to the user on the client side.  Flash contains four (default) subcollections, ```successes```, ```notices```, ```warnings```, and ```errors```.  When these collections are appended to the message will be displayed in a div with the classes of ```"alert alert-{{ ..collection name.. }}"```

### Example

```ruby
flash._successes << "Your data has been saved"
```

```ruby
flash._errors << "Unable to save because your not on the internet"
```

Strings added to any subcollection on flash will be removed after 5 seconds.  By default the flash message can be clicked on to clear.

# Local Store Collection

The ```local_store``` collection persists its data the browsers local store.

# Cookies Collection

The ```cookies``` collection stores data in a browser cookie.  Each assigned property gets saved to a cookie of the same name:

```ruby
cookies._user_id = 520

puts cookie._user_id
# => "520"

cookies.delete(:user_id)
```

 Values in the cookie collection are converted to a string.  Adding expiration and other options are still on the todo list.  Right now cookies default to 1 year expiration.


