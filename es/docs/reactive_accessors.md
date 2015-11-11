## Accessors Reactivos

```Volt::ModelController``` envia todos los llamados a métodos desconocidos al modelo asignado. A veces necesitas un store adicional (que maneje los datos reactivamente por fuera del modelo, aunque si vas a hacer esto tal vez debas considerar el crear otro controlador). En este caso, puedes añadir un ```reactive_accesor```. Este se comporta como un ```attr_accessor```, con la excepción de que los datos asignados retornan los datos reactivamente.

```ruby
module Main
  class Contacts < Volt::ModelController
    reactive_accessor :query
  end
end
```

Ahora, desde la vista puedes enlazar el método ```query``` y también puedes cambiar los elementos del modelo enlazado al controlador. Cuando ```query``` es accedido el controlador toma esto en cuenta y realiza los cambios necesarios para las vistas enlazadas.
