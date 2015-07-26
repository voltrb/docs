# Component Gems

Components can easily be shared as a gem.  Volt provides a scaffold command for creating component gems.  In a folder (not in a volt project), simply type: ```volt generate gem {component_name}```.  This will create the files needed for a new gem.  Note that all volt component gems will be prefixed with ```volt-``` so that they can easily be found by others on github and rubygems.  You should use underscores in the component name to follow the gem naming convention.

While developing, you can use the component by placing the following in your Gemfile:

```ruby
gem 'volt-{component_name}', path: '/path/to/folder/with/component'
```

Once the gem is ready, you can release it to rubygems with:

```
rake release
```

Remove the ```path:``` option in the gemfile if you wish to use the rubygems version.

Modified at {{ file.mtime }}
