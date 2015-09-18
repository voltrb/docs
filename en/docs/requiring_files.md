# Requiring Files

If a file is at, say: `my_awesome_app/app/main/mixins/my_file.rb`, where `my_awesome_app` is your application's root, and `main` is the component the file is in, you can require it in another file with:

```ruby
require "main/mixins/my_file"
```

That is, with the path starting at the component folder.