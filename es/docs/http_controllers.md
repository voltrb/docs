# Controladores HTTP

Los controladores HTTP pueden ser usados como endpoints. La mayor parte de la comunicación del cliente se la hace por medio de websockets (u otros fallbacks de socket) por lo que no se usa Http para la sincronización de datos con el cliente, excepto para la carga inicial de la página. Los controladores HTTP nos proveen una manera fácil para enviar datos a terceros que necesitan acceso a los datos (por medio de un API REST, por ejemplo) por medio de HTTP.

## Routing

Para usar Controladores HTTP necesitas configurar tus rutas en el [Archivo de Rutas](routes_file.md)

## Creando un contolador

Puedes crear un controlador HTTP creando un archivo en ```app/component_name/controllers/server/``` y heredando de ```Volt::HttpController```

```ruby
module Main
  class TodosController < Volt::HttpController
    def index
      #perform some action
    end
  end
end
```

Por convención el nombre de la clase debe terminar en "Controller". En volt, la carpeta ```server``` nos indica que el código solo debe ser cargado en el servidor. De todas maneras ten en cuenta que el nombre de un controlador no puede ser el mismo que el de otro controlador (ModelController o HttpController) dentro del componente.

## Params

Puedes acceder a los params por medio del método ```#params```. A diferencia del método params de los [Controladores](controllers.md), el ```#params``` dentro de ```Volt::HttpController``` es simplemente un hash con símbolos usados para los keys. Los keys :controller y :action almacenan el controlador actual y la acción ejecutada. Puedes sobrescribir el método HTTP configurando :method en cualquiera de los dos.

## Accediendo al store

Puedes ingresar al store del controlador por medio del método ```#store```

## Accediendo al body del request

Por ahora el body del request tiene que ser parseado manualmente. Puedes obtener acceso a este por medio del objeto ```request```.

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
      data = JSON.parse(request.body)
      store._links! << Link.new(data)
    end
  end
end
```

## Respondiendo a un request

Puedes responder a un request por medio de los métodos```render```, ```#head``` o ```redirect_to```.

## Renderizando un response

Puedes responder a un request renderizando JSON o usando texto plano usando el método ```#render```. ```#render``` toma un hash como argumento.  Tienes que configurarlo con los símbolos ```:json``` o  ```:text```.

```ruby
module Main
  class TodosController < Volt::HttpController
    def show
  	  data = { some: "data" }
  	  render json: data
    end
  end
end
```

Por default el rendering reponderá con el código HTTP 200. Puedes cambiar esto añadiendo el key ```status:``` al hash. Los keys restantes seran procesados como headers HTTP adicionales.

### Redirección

La redirección se la hace por medio del método ```#redirect_to```. Debes ingresar el lugar al cual se va redirigir como primer argumento y el status como segundo argumento (opcional). El status code por default es 302.

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
  	  #do something
  	  redirect_to '/todos'
    end
  end
end
```

### head

Si no necesitas usar redirecting o rendering, puedes simplemente enviar el estado por medio del método ```#head```.

```#head``` toma el status code como el primer argumento y un hash opcional con headers adicionales como segundo argumento. Puedes usar un símbolo como status code. mira la sección HTTP_STATUS_CODES en [http://www.rubydoc.info/github/rack/rack/Rack/Utils](http://www.rubydoc.info/github/rack/rack/Rack/Utils) para obtener mas detalles.

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
      head :no_content
    end
  end
end
```

### Headers

Puedes añadir tus propios HTTP headers a tu response. Las headers customizados seran transformados:

:auth_token se transformará en 'Auth-Token'. Puedes configurar los headers usando ```Symbol``` o un ```String```. ```:auth_token == 'Auth-Token' == 'auth-token' == 'Auth_Token'```
