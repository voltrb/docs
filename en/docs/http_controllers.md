# HTTP Controllers


HTTP Controllers can be used as HTTP endpoints.  Volt does most client side communication via websockets (or other socket fallbacks) so it does not use Http for data synchronization to the client, except for the initial page load.  HTTP Controllers provide an easy way to provide data to third parties who need to access data (a REST API for example) via HTTP.

## Routing

To use HTTP Controller you need to set up corresponding routes in your [Routes File](routes_file.md).

## Creating a controller

You can create an HTTP Controller by placing a file under ```app/component_name/controllers/server/``` and inherit from ```Volt::HttpController```
```ruby
module Main
  class TodosController < Volt::HttpController
    def index
      #perform some action
    end
  end
end
```

By convention the class name has to end with "Controller".  In volt, the ```server``` folder denotes that the code should only be loaded on the server.  Keep in mind however that your controller name should not be the same as another controller (ModelController or HttpController) in the component.

## Params

You have access to the params via the ```#params``` method. Unlike the params available in the [Controllers](controllers.md), ```#params```  inside a ```Volt::HttpController``` is a simple hash with symbolized keys. They keys :controller, :action and are set to the controller and performed action. You can overwrite the HTTP method by setting the :method to either

## Accessing the store

Within your controller you can access your store via the provided ```#store``` method.

## Accessing the request body

For now the request body has to be parsed manually. You can access the body via the ```request``` object.

```ruby
module Main
  class TodosController < Volt::HttpController
    def create
      data = JSON.parse(request.body.read)
      store._links! << Link.new(data)
    end
  end
end
```

## Responding to a request

You can respond to a request via the ```#render```, ```#head``` or ```#redirect_to``` methods.

### Rendering a response

You can respond to a request by rendering JSON or plain text using the ```#render``` method. ```#render``` takes a hash as argument. You need to either set the ```:json``` or ```:text``` key.

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

By default rendering will respond with HTTP status code 200. You can overwrite this by adding the ```status:``` key to the argument hash. All remaining keys are processed as additional HTTP headers.

### Redirecting

Redirecting can be done with the ```#redirect_to`` method. You have to supply a location as first argument and a status code as optional second argument. the default status code is 302.

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

If neither redirecting nor rendering a response is required, you can just set the status with the ```#head``` method.

```#head``` takes a status code as first argument and an optional hash with additional headers as second. You can use the symbols as status code. See the HTTP_STATUS_CODES section in [http://www.rubydoc.info/github/rack/rack/Rack/Utils](http://www.rubydoc.info/github/rack/rack/Rack/Utils) for more details.

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
You can add custom HTTP headers to your response. The custom headers will be transformed:

:auth_token will be transformed to 'Auth-Token'. You can either set headers by using a ```Symbol``` or a ```String```.
   ```:auth_token == 'Auth-Token' == 'auth-token' == 'Auth_Token'```
