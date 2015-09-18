# Colecciones Store

La colección store guarda los datos directamente en un BD. Por ahora la única base de datos soportada es Mongo (Se añadirá soporte para mas bases de datos muy pronto, RethinkDb y postgres serán probablemente las primeras). Por el hecho de que ```store``` a veces necesita esperar a que los datos vengan del servidor, todos los métodos query hechos a store retornan una promesa. Si eres nuevo en el tema de promesas, puedes leer mas acerca de este tema en la sección de [Promesas en Opal](http://opalrb.org/docs/promises/).

En Volt, puedes acceder a ```store``` en el front-end y en el back-end.  Los datos seran sincronizados automáticamente entre el browser y el servidor. Cualquier cambio a los datos en ```store``` se reflejará en todos los clientes que se encuentren usando esos datos (excepto en el caso de que usen [buffers](#buffers)).

```ruby
store._items.create({name: 'Item 1'})
# => #<Promise(70297824266280): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>

store._items[0]
# => #<Promise(70297821413860): #<Volt::Model id: "9a46..5dd7", name: "Item 1">>
```

Al llamar a ```create``` (o ```append``` o ```<<```) en ```store._items``` este creará una tabla ```items``` en el data store (si es que aún no existe) e insertará el documento del modelo en el mismo. [Un identificador global único](http://en.wikipedia.org/wiki/Globally_unique_identifier) ```id``` será generado automáticamente.

## Promesas en store

Para poder soportar cargas asíncronas, los métodos en el store de ArrayModel deben retornar una promesa. Si quieres trabajar con los resultados de un query, puedes llamar al método ```.then``` sobre este.

```ruby
store._items.first.then do |item|
  # work with item
end
```

[Mira aquí](http://opalrb.org/blog/2014/05/07/promises-in-opal/) para mayor información acerca de promesas en ruby/opal.

## Promesas en Bindings

Las promesas se pueden pasar a los bindings y los bindings se actualizarán con el valor una vez que la promesa ha sido resuelta. Esto significa que puedes hacer lo siguiente:

```html
{{ store._items.first.then {|i| i._name } }}
```

Este código tomará el primer item, luego retornará el nombre una ves que se haya resuelto. Esto también preserva la reactividad, ya que si el primer item es modificado, este volverá a correr el binding.

## Forwarding de métodos en las Promesas

Para hacer el ejemplo anterior un poco mas sencillo, Volt extiende las promesas de tal manera que puedes llamar métodos directamente en las promesas y este llamará al método en el valor obtenido una vez que la promesa ha sido resuelta. Lo siguiente es semanticamente igual al código anterior:

```ruby
store._items.first.then {|i| i._name }
store._items.first._name
```

## Sincronización de Promesas

Si te encuentras obteniendo datos de store directamente desde el servidor (en un task por ejemplo), puedes llamar al método ```.sync``` en la promesa para que esta resuelva sincrónicamente y retorne el resultado. Si la promesa es rechazada ```.sync``` nos retornará un error.

```ruby
# Remember this only works on the server or console

store._items.create({name: 'Item 1'})

# .sync blocks until the items are loaded
store._items.first.sync
# => #<Volt::Model id: "3607..a0b0", name: "Item 1">

store._items.size.sync
# => 1
```

## Querying

Por el momento los datos son persistidos en una base mongodb. Estamos trabajando en un API que funcionará para distintos data store. Volt soporta al momento los siguientes métodos query:

### .where

```.where``` pasa los argumentos al método ```.find``` de mongodb.

### .limit

```.limit``` te permite restringir la cantidad de datos que quieres

### .skip

```.skip``` nos indica cuantos items queremos obtener. Por lo que store._items.skip(5).limit(10) obtendrá los índices en este rango: 5-15.

### .order

```.order``` pasa sus argumentos al método ```.sort``` de mongodb.  Ya que ```.sort``` es también un método de la clase Enum en Ruby se tuvo que usar ```.order``` en este caso.

### Estado del Modelo Store

Por el hecho que existe un delay al momento de sincronizar los datos con el servidor, los modelos store proveen el método ```loaded_state``` que nos permite determinar si el modelo se encuentra en proceso de carga.

| estado      | descripcion                                                  |
|-------------|--------------------------------------------------------------|
| not_loaded  | los datos aun no han sido cargados                                           |
| loading     | el modelo esta obteniendo datos desde el servidor                       |
| loaded      | los datos se han cargado y se encuentran sincronizados |
| dirty       | los datos han sido cargados, pero ya no se sincronizan con el servidor |
