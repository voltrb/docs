## Clases del Modelo

Por default todas las colecciones usan la clase ```Volt::Model```.

```ruby
    page._info!.class
    # => Volt::Model
```

Puedes creer tu propia clase base para tus modelos. Estas clases modelo deben heredar de ```Volt::Model```. Puedes guardarlas dentro del directorio app/{component}/models del componente respectivo. Por ejemplo, puedes añadir ```app/main/info.rb```:

```ruby
    class Info < Volt::Model
    end
```

Ahora cuando accedas a cualquier subcolección llamando ```_info``` esta se cargará como una instancia de ```Info```

```ruby
    page._info!.class
    # => Info
```

Esto nos permite crear métodos customizados y validaciones de colecciones.
