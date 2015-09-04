# Dependencias

También puedes usar [tags](#tags) y llamarlos a través de componentes.  Para hacer esto debes hacer `require` del componente dentro del componente desde el cual lo vas a usar. Esto puedes hacerlo mediante el archivo ```config/dependencies.rb```. Solo agrega

```ruby
component 'component_name'
```

dentro del archivo.

Las dependencias actuan como un ```require``` normal de ruby, pero para añadir componentes.

A veces necesitarás incluir un JS externo de un componente. Para hacer esto, simplemente has lo siguiente en el archivo dependencies.rb:

```ruby
javascript_file 'http://code.jquery.com/jquery-2.0.3.min.js'
css_file '//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css'
```

Nota: De todas maneras, jquery y bootstrap están añadidos por default en Volt
