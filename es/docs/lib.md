# Lib

**Nota:** Esta sección todavía esta en contrucción

Las gemas del Gemfile no son cargadas automáticamente en Volt. Este decisión se tomó por distintos motivos.

1. Incrementa el tiempo de carga, especialmente en aplicaciones muy grandes (una de las cosas mas criticadas en rails). Las gemas de componentes incluidas en el archivo dependencies.rb tendrá las partes de la
aplicación incluídas por default.
2. De esta manera no se carga código que no vamos a utilizar.

Revisa [5 razones para evitar Bundler.require](http://myronmars.to/n/dev-blog/2012/12/5-reasons-to-avoid-bundler-require)

Si de todas manera quieres incluir los archivos para las gemas automáticamente, puedes inluir lo siguiente al principio de tu archivo ```config/app.rb```.

```ruby
Bundler.setup
```
