## Buffers

En Volt, todos los modelos se guardan automáticamente y todos los cambios se persisten en una base u otro repositorio. Por ejemplo, si cambiamos el nombre de un modelo en ```store```, estos cambios se sincronizarán automáticamente con la base de datos y otros clientes. A diferencia de otros frameworks, no existe la necesidad de llamar a un método save, los modelos se sincronizarán mientras los valores sean cambiados.

```ruby
store._items.first.then do |item|
    item._name = 'New Item Name'
    # ...syncs back to db
end
```

En otro ejemplo, si cambiamos el valor de ```index``` en los params, la url será actualizada cuando la variable index sea cambiada

```ruby
params._index = 20
# ...url is updated
```

Gracias a que la colección store es sincroniza automáticamente con el backend, cualquier cambio en modelo tambien lo podrán ver otros clientes inmediatemente.  A menudo no se querrá tener los datos sincronizados todo el tiempo. Para facilitar la creación de un app [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) , Volt nos proveé el concepto de "buffer". Un buffer puede ser creado partiendo de un modelo y este no se almacenará en el modelo inicial mientras no llamemos al metodo ```save!``` en el buffer. Esto nos permite crear un formulario donde los cambios no se guardaran mientras no presionemos el boton de submit.

```ruby
store._items << {name: 'Item 1'}

store._items[0].then do |item1|
  item1_buffer = item1.buffer

  item1_buffer._name = 'Updated Item 1'
  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Item 1'

  item1_buffer.save!

  item1_buffer._name
  # => 'Updated Item 1'

  item1._name
  # => 'Updated Item 1'
end
```

```#save!``` en el buffer también retorna una [promesa](http://opalrb.org/blog/2014/05/07/promises-in-opal/) que se resolverá una vez que los datos han sido guardados en el servidor.

```ruby
item1_buffer.save!.then do
  puts "Item 1 saved"
end.fail do |err|
  puts "Unable to save because #{err}"
end
```

Cuando llamamos .buffer en modelo existente este nos retorna un buffer para para esa instancia de modelo. Si llamas .buffer en un Volt::ArrayModel obtendrás un buffer para un item en esa colección. Luego el llamado a .save! añadirá el item a esa subcolección, similar a si lo hubiésemos hecho mediante ```<<``` o ```create``` para añadir el item a la colección.
