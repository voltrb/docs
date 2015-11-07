## Eventos ArrayModel

Los ArrayModels lanzan eventos cuando los datos son actualizados. Actualmente
los modelos pueden generar dos eventos ```added``` y ```removed```. Por ejemplo:

```ruby
page._items.on('added') { puts 'item added' }
page._items << 1
# => item added

page._items.on('removed') { puts 'item removed' }
page._items.delete_at(0)
# => item removed
```

Esto es usado internamente para los each bindings, pero puedes usarlo
en tu propio código.

NOTA: Los eventos de ArrayModel son por ahora un 'feature' no oficial de
volt. No hay garantías de que funcione bien en todos los casos
