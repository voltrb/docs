## Modelos Nil

Por conveniencia, al llamar a un método como ```page._info``` este nos retornará un ```NilModel``` (asumiendo que la variable aún no ha sido inicializada). Los modelos nil o NilModels nos permite enlazar métodos con muchas anidaciones sin tener que inicializar primero los valores intermedios.

```ruby
page._info
# => <Volt::Model:70260787225140 nil>

page._info._name
# => <Volt::Model:70260795424200 nil>

page._info._name = 'Ryan'
# => <Volt::Model:70161625994820 {:info => <Volt::Model:70161633901800 {:name => "Ryan"}>}>
```

Uno de los incovenientes de NilModels es que son tratados como un valor verdadero (como valores truthy), ya que solo nil y false son tratados como valores 'falsy' en Ruby. Para facilitar un poco las cosas NilModel contiene un método ```nil?``` el cual siempre retorna true.

Un uso muy común de la verificación de valores 'truthy' es al momento de crear valores por defecto por medio de ```||``` (or lógico). Volt proveé un método que hace exactamente lo mismo: ```#or``` el cual funciona con NilModels.

Reemplaza esto:

```ruby
    a || b
```

Con esto:

```ruby
    a.or(b)
```

Adicionalmente, ```#and``` funciona igual que ```&&```
