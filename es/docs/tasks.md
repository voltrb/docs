# Tasks

A veces necesitas ejecutar explícitamente una parte del código en el servidor.  Volt nos permite hacer esto por medio de tasks. Puedes definir tus propios tasks heredando de la clase ```Volt::Task```. Los archivos de Ruby dentro de la carpeta ```tasks``` (y que terminen en ```_tasks.rb```), serán cargados automáticamente.

```ruby
# app/main/tasks/logging_tasks.rb

class LoggingTasks < Volt::Task
  def log(message)
    puts message
  end
end
```

Volt crea automáticamente wrappers de estos tasks en el cliente, los cuales retornarán un promise.

*Hay que tomar en cuenta que el código de los tasks en el cliente usan métodos de instancia mientras las clases wrapper representan estos métodos como métodos de clase*, para mas información de como usar promesas revisa el código de Opal [Aqui](http://opalrb.org/blog/2014/05/07/promises-in-opal/).

```ruby
class Contacts < Volt::ModelController
  def hello
    promise = LoggingTasks.log('Hello World!')
  end
end
```

Puedes usar el método ```#then``` de la promesa para obtener el resultado de llamar a ese método. Puedes usar ```#fail``` en la promesa para obtener los errores obtenidos.

```ruby
MathTasks.add(23, 5).then do |result|
  # result should be 28
  alert result
end.fail do |error|
  puts "Error: #{error}"
end
```
