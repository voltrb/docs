# Comando Volt

El comando volt proveé varios helpers para manejar un proyecto y trabajar con sus datos

## new

Puedes usar ```volt new project_name``` para crear un nuevo proyecto.  El comando 'new' creará una aplicación básica de volt.

NOTA: El comando 'new' es el único comando que se debe correr sin ```bundle exec```. El resto de comandos deben usar ```bundle exec``` al principio del comando.

## generate

El comando generate puede usarse para crear generadores de código.

### model

```bundle exec volt generate model NAME COMPONENT```

NAME es el nombre del modelo que quieres generar. Este debe estar en singular.  si COMPONENT no es especificado, volt usará el componente ```main```.

Ejemplo:

```bundle exec volt generate model item```

### component

```bundle exec volt generate component NAME```

El generador de componentes creará un nuevo componente dentro de ```app```.

Ejemplo:

```bundle exec volt generate component blog```

### gem

```bundle exec volt generate gem NAME```

Gem genera los archivos necesarios para crear una gema de componente.  Los gems de componentes nos permiten reutilizar componentes fácilmente entre proyectos.

### view

```bundle exec volt generate view NAME COMPONENT```

View genera los archivos necesarios para crear una vista de Volt.  Si no existe un model controller con el mismo nombre, este será creado áutomaticamente.

Se puede pasar opcionalmente el nombre de un componente, el default es 'main'

### task

```bundle exec volt generate task NAME COMPONENT```

'task' genera los archivos para crear un task de Volt. Se puede pasar opcionalmente el nombre de un componente, el default es 'main'

### model controller

'model controller' genera los archivos para crear un modelo controlador de Volt.  Se puede pasar opcionalmente el nombre de un componente, el default es 'main'

### http_controller

```bundle exec volt generate http_controller NAME COMPONENT```

'http_controller' genera los archivos para crear un controlador http de Volt.  Se puede pasar opcionalmente el nombre de un componente, el default es 'main'

## server

```bundle exec volt server```

El servidor corre en el puerto 3000 por defecto.

Opciones:
1. -p, [--port=el puerto en el que va a correr]
2. -b, [--bind=el servidor al que se va a enlazar]
