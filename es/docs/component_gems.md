# Gemas de Componente

Los competentes pueden ser fácilmente compartidos por medio de una gema de Ruby.  Volt proveé métodos scaffold para crear gemas de componente. En una carpeta ( no dentro de un proyecto volt) digita lo siguiente: ```volt generate gem {component_name}```.  Esto creará los archivos necesarios para la nueva gema. Toma en cuenta que las gemas de componentes tendrán un prefijo ```volt-``` para que se puedan localizar fácilmente en github o rubygems. Usa la convención de usar underscores para los espacios en el nombre de la gema

Ahora ya puedes usar tu componente agregando lo siguiente a tu Gemfile:

```ruby
gem 'volt-{component_name}', path: '/path/to/folder/with/component'
```

Una ves que la gema este lista puedes publicarla en rubygems con el siguiente comando:

```
rake release
```

Borra la opción ```path:``` en el gemfile si quieres usar directamente la versión guardada en rubygems.
