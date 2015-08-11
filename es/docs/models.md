# Modelos

Los modelos en volt difieren en cierta forma de otros frameworks, donde el modelo es simplemente el nombre dado en el ORM para acceder a la base. En Volt, el modelo es una clase donde puedes guardar tus datos fácilmente. Los modelos pueden ser creados opcionalmente con un ```Volt::Persistor```, el cual es responsable de guardar los datos (a una base de datos, store local , parametros url, etc...).  Los modelos creados sin un persistor simplemente guardan los datos en la instancia de la clase. Primero veamos como se usa un modelo.

Un modelo es simplemente una instancia de Volt::Model. Empezemos creando una instancia directamente:

```ruby
item = Volt::Model.new
item
# <Volt::Model {:id=>"beb492e2997ebd1365d3bf83"}>
```

Los modelos en Volt son asignados automáticamente con un id. Los modelos son similares a los hashes en el hecho de que puedes añadir u obtener datos de los mismos. Existen dos formas de acceder a las propiedades de un modelo

- accesors con (_) undescore
- campos de modelo

## Accesors con Underscore

Primero miremos como acceder a las propiedades por medio de underscore. Esto nos permite crear cualquier propiedad sin tener que definirla con anterioridad

```ruby
item = Volt::Model.new
item._name = 'Ryan'
item._name
# => "Ryan"

item
# => <Volt::Model {:id=>"d8872b283c6dc1a7861e9baa", :name=>"Ryan"}>
```

Toma en cuenta que no inicializamos ninguna campo . Al usar un undescore (_) antes de cualquier de variable podemos obtener o crear una propiedad de un modelo. (esto es similar a llamar ```[:property]``` en un hash. [Revisa esto](/getting_help/why_use_underscore_accessors_instead_of_[property].md) para mayor información).

Los accesors definidos con underscore son usados comunmente para prototipado, antes de decidir exactamente  que campos son los que vamos a usar.

# Campos

Una vez que tenemos mas claro que campos vamos a usar, podemos crear una clase de modelo y especificar los campos. La clase modelo hereda de ```Volt::Model``` y debe ser creado dentro de app/{component}/models/model_name.rb (Si eres nuevo en Volt, es preferible que uses 'main' como el componente). Puedes crear un nuevo modelo con el siguiente generator:

```bash
bundle exec volt generate model Item
```

Una vez que hayas creado la clase puedes añadir los campos en el modelo y ya no tendrás que definirlos u obtenerlos con underscore.

```ruby
class Post < Volt::Model
  field :title
  field :body, String
end
```

Los campos pueden tener una restricción de tipo. Una ves que hayas agregado los campos, estos pueden ser leídos y asignados llamando directamente al método de la propiedad.

```ruby
new_post = Post.new(body: 'it was the best of times')

new_post.title = 'A Title'

new_post.title
# => 'A Title'

store._posts << new_post
```

## Colecciones

Ya que los modelos de volt no pueden persistir datos directamente, podemos acceder a estos a través de una colección, la cual maneja todo lo referente a la persistencia. Volt viene con distintos tipos de colecciones, la colección page, por ejemplo, al ser invocada en la consola (o en un controlador) nos dará acceso a la colección de la página.

```ruby
page._name = 'Ryan'
page._name
# => 'Ryan'
```

Las colecciones simplemente retornan un modelo root con la configuración para guardar los datos en el modelo, este puede devolvernos un valor o retornarnos ```nil``` si este aún no ha sido definido.

## Anidamiento

También puedes tener métodos anidados.

```ruby
page._setting = {}
page._setting._color = 'blue'
page._setting._color
# => 'blue'
```

Asignar un hash vacío a una propiedad creará otro modelo, el cual será asignado a la propiedad ```setting``` en ```page```. El modelo ```setting``` puedo luego ser asignado con sus propias propiedades.

Si quieres tener atributos anidados sin tener que crear un modelo con ```{}``` puedes usar ```!``` al crearlo.

```ruby
page._setting!._color = 'blue'
page._setting._color
# => 'blue'

page
# => <PageRoot {:id=>"0df58b9f8b6b6f3404ea4d7b", :setting=><Volt::Model {:id=>"5ea3193e429c1f2ecba21bc5", :color=>"blue"}>}>
```

Al llamar a ```._setting``` se creará automáticamente un nuevo modelo (si el nombre no se asigno antes). A esto se le llama "expanding"

## ArrayModels

En volt, cuando definimos propiedades en plural esta nos retornará una instancia de ```Volt::ArrayModel```. Los ArrayModels se comportan de la misma manera que arreglos normales. Puedes agregar o remover items del arreglo como en un arreglo normal con los métodos ```#<<```, ```push```, ```append```, ```delete```, ```delete_at```, etc.

```ruby
page._items
# #<Volt::ArrayModel []>

page._items << {name: 'Item 1'}

page._items
# #<Volt::ArrayModel [<Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>]>

page._items.size
# => 1

page._items[0]
# => <Volt::Model {:id=>"997e8a28c9675452ebcd5fa7", :name=>"Item 1"}>
```
