# Tag Events and Triggering

When using tags in volt, you can have your controller trigger events that can be handled when someone uses the tag.

Example:


```html
<:upload e-uploaded="was_uploaded" />
```

In the above example, we can have an upload button that calls the code in the e-uploaded Event Binding when the upload controller triggers the 'uploaded' event.

Here's an example of triggering:

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... handle the upload ..

      # Trigger the uploaded event.
      trigger('uploaded')
  end
end
```

Tag Events also will bubble up the dom, so we could catch it higher up the DOM if we wanted.  (on any parent tag):

```html
<div e-uploaded="was_uploaded">
  <p>
    Upload 1:
    <:upload />
  </p>
  <p>
    Upload 2:
    <:upload />
  </p>
</div>
```

In the above example, ```was_uploaded``` would be called if either of the two upload tags triggered an uploaded event.

## Passing arguments

You can pass arguments when you trigger an event.

```ruby
module Main
  class UploadController < Volt::ModelController
    def upload
      # ... handle the upload ..

      # Trigger the uploaded event.
      trigger('uploaded', file_name)
  end
end
```

In the case above, we might pass a file_name argument to the event.  In our controller for the view where we used the tag, our ```was_uploaded``` method will look like this:

```ruby
module Main
  class MyDocumentsController < Volt::ModelController
    def was_uploaded(file_name)
      # ... do something with the file ...
    end
  end
end
```

Any arguments that we pass to trigger after the event name will be passed into our method in the e- binding.

## Getting the controller

If the method the event binding calls has an extra argument (compared to the number it was triggered with), the event binding will pass in a ```JSEvent``` object.  (See [EventBindings](event_bindings.md) for more info)  On the ```JSEvent```, you can get the controller that triggered the event (if it was not a DOM event) by calling ```event.controller```.

## Methodizing

The following is a technical detail, but its useful to know.

The strings passed to e- bindings are converted to either a Proc or a ruby Method object depending on what we pass.  If the string we pass has parenthesies on the end, it assumes this is a method call where you want to pass in custom arguments.

```<:upload e-uploaded="was_uploaded('done')" />```

The above would be converted to a Proc that would be called when the uploaded event triggers.  If the last part of the string does not have parenthesis, it is assumed you are passing a reference to a method and it is turned into a method (by changing the string to use ```method(:last_part_str)```

So for example, the following:

```<:upload e-uploaded="upload_handler.was_uploaded" />```

The e-uploaded event binding would receive the following:

```ruby
upload_handler.method(:was_uploaded)
```
