# Puede usar gemas de opal?

Si. Opal tiene su propia forma de incluir gemas. Esto generalmente significa que tienes que incluir la gema en tu código MRI antes de que sea añadida al load path de opal.

Por ejemplo con opal/browser, puede simplemente añadir lo siguiente en config/app.rb

```ruby
require 'opal/browser'
```

Luego añade lo siguiente en el controlador (al principio del archivo) en el cual usaremos opal-browser:

```ruby
if RUBY_PLATFORM == 'opal'
  require 'browser'
end
```
