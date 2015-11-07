# Runners/Processes

Si quieres correr código fuera de un request normal, puedes hacerlo de estas 2 formas:

## 1) Runners

Puedes poner código dentro de la carpeta lib, por ejemplo en ```app/main/lib/some_runner.rb```, luego puedes correr el código
dentro de este archivo por medio del siguiente comando:

```bundle exec volt app/main/lib/some_runner.rb```

Este comando levantará la aplicación antes the correr el código dentro del archivo .rb

## 2) Arranca la aplicación con 'boot'

Si necesitar corrar la aplicación dentro de otro contexto. Por ejemplo, para correr una gema como [clockwork](https://github.com/tomykaira/clockwork),
la cual tiene sus propios comandos, puedes correrla por medio del siguiente código:

```ruby
require 'volt/boot'
Volt.boot(Dir.pwd)
```
```Volt.boot``` toma un solo argumento: el path donde se encuentra la aplicación volt. Acuerdate de usar el comando ```bundle exec``` y
de tener el archivo Gemfile para poder inicializar todas las dependencias.
