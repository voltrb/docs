# Renderizado

Cuando un usuario interactúa con la página, generalmente queremos hacer dos cosas:

1. Cambiar el estado de la aplicación
2. Actualizar el DOM

Por ejemplo, cuando un usuario hace click para agregar un nuevo item en nuestra lista de tareas este creará un nuevo objeto, el cual representa un item TODO que sera añadido en el DOM. El verdadero reto al realizar esto es lograr que estos datos estén sincronizados (y que los cambios se actualizen asincronamente).

El concepto de 'programación reactiva' puede ser usado para solucionar el problema de mantener el DOM actualizado. En lugar de tener eventos que manejen los modelos y el DOM al mismo tiempo podemos tener eventos que actualizen modelos de datos reactivos. En este estilo de programación describimos nuestra capa DOM de una manera declarativa y este a su vez sabe como cargar datos y mantenerlos actualizados con los modelos.

## Estado y Computaciones

Generalmente las aplicaciones web giran en torno al manejo de estados.  Existen muchos eventos que pueden activar cambios en un estado.  Interacciones de página como escribir mensajes en un formulario, hacer click en un botón o link, scrolling, etc. pueden cambiar el estado de una aplicación. En el pasado, cada interacción con la página era cambiada manualmente y su estado era guardado en la página.

En Volt, para simplificar el manejo del estado de la aplicación este se guarda en los modelos, los cuales pueden ser almacenados en distintos lugares. Al centralizar el estado de la aplicación reducimos la cantidad de código necesario para actualizar la página. Luego podremos construir nuestros html's de una manera mas declarativa. Las relaciones entre la página y los modelos son enlazados usando funciones y llamados a funciones.

Nuestro objetivo es que nuestro DOM se actualize automáticamente cuando los datos de nuestro modelo cambien. Para hacer esto posible Volt nos deja 'vigilar' cualquier método y proceso para encontrar actualizaciones.

## Computaciones

Como usuario Volt, rara ves tendrás que usar Computaciones y dependencias directamente. Generalmente usarás los modelos y enlaces provistos. Las computaciones son usados por debajo y entenderlos nos ayudarán a saber un poco mas del proceso.

Demos un vistazo de las computaciones por medio de un ejemplo. Usaremos la colección ```page``` como ejemplo. (Aprenderás mas acerca de colecciones en los siguientes capitulos).

Primero, vamos a crear un 'computation watch'. Las computaciones son creadas llamando al método ```.watch!```. Este correrá una vez, luego correrá cada vez que los datos en ```page._name``` cambien.

```ruby
page._name = 'Ryan'
-> { puts page._name }.watch!
# => Ryan
page._name = 'Jimmy'
# => Jimmy
```

Cada vez que ```page._name``` es asignado con un nuevo valor, la computación correra de nuevo. Los llamados a la computación seran activados cuando cualquier dato ha cambiado (desde la última vez que se corrió la computacion). Esto nos permite tener acceso a los datos mediante los métodos y al mismo tiempo vigilar cuando los datos han cambiado.

```ruby
page._first = 'Ryan'
page._last = 'Stout'

def lookup_name
  return "#{page._first} #{page._last}"
end

-> do
  puts lookup_name
end.watch!
# => Ryan Stout

page._first = 'Jimmy'
# => Jimmy Stout

page._last = 'Jones'
# => Jimmy Jones
```

Cuando llamas al método ```.watch!```, el valor retornado es un objeto ```Volt::Computation```.  En el caso de que ya no se quiera recibir mas actualizaciones, puedes llamar al método ```.stop``` en la computación.

```ruby
page._name = 'Ryan'

comp = -> { puts page._name }.watch!
# => Ryan

page._name = 'Jimmy'
# => Jimmy

comp.stop

page._name = 'Jo'
# (nothing)
```
