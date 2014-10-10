## Model Classes

By default all collections use the Model class by default.

```ruby
    page._info.class
    # => Model
```

You can provide classes that will be loaded in place of the standard model class.  You can place these in any app/{component}/models folder.  For example, you could add ```app/main/info.rb```  Model classes should inherit from ```Model```

```ruby
    class Info < Model
    end
```

Now when you access any sub-collection called ```_info```, it will load as an instance of ```Info```

```ruby
    page._info.class
    # => Info
```

This lets you set custom methods and validations within collections.
