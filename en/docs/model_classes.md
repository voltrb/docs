## Model Classes

By default all collections use the ```Volt::Model``` class.

```ruby
    page._info!.class
    # => Volt::Model
```

You can provide classes that will be loaded in place of the standard model class. Model classes should inherit from ```Volt::Model```. You can place these in any app/{component}/models folder. For example, you could add ```app/main/info.rb```:

```ruby
    class Info < Volt::Model
    end
```

Now when you access any sub-collection called ```_info```, it will load as an instance of ```Info```

```ruby
    page._info!.class
    # => Info
```

This lets you set custom methods and validations within collections.

Modified at {{ file.mtime }}
