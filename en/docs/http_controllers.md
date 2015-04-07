# HTTP Controllers

HTTP Controllers can be used as HTTP endpoints.

1. Routing

   To use HTTP Controller you need to set up corresponding routes in your [Routes File](routes_file.md).

2. Creating a controller

   You can create an HTTP Controller by placing a file under ```app/component_name/controllers/server/``` and inherit from ```Volt::HttpController```
   ```ruby
   class TodosController < Volt::HttpController
     def index
     	#perform some action
     end
   end
   ```
   By convention the class name has to end with "Controller".

2. Params

   You have access to the params via the ```#params``` method. Unlike the params available in the [Controllers](controllers.md), ```#params```  inside a ```Volt::HttpController``` is a simple hash with symbolized keys. They keys :controller, :action and are set to the controller and performed action. You can overwrite the HTTP method by setting the :method to either 

3. Accessing the store

   Within your controller you can access your store via the provided ```#store``` method.

4. Accessing the request body

   For now the request body has to be parsed manually. You can access the body via the ```request``` object.
   ```ruby
   class TodosController < Volt::HttpController
     def create
     	data = JSON.parse(request.body)
     	store._links! << Link.new(data)
     end
   end
   ```

5. Responding to a request

   You can respond to a request via the ```#render```, ```#head``` or ```#redirect_to``` methods.

   1. Rendering a response
      You can respond to a request by rendering JSON or plain text using the ```#render``` method. ```#render``` takes a hash as argument. You need to either set the ```:json``` or ```:text``` key. 

      ```ruby
      class TodosController < Volt::HttpController
        def show
        	data = { some: "data" }
        	render json: data
        end
      end
      ```

      By default rendering will respond with HTTP status code 200. You can overwrite this by adding the ```status:``` key to the argument hash. All remaining keys are processed as additional HTTP headers.

   2. Redirecting

      Redirecting can be done with the ```#redirect_to`` method. You have to supply a location as first argument and a status code as optional second argument. the default status code is 302.

      ```ruby
      class TodosController < Volt::HttpController
        def create
        	#do something
        	redirect_to '/todos'
        end
      end
      ```

   3. head
      If neither redirecting nor rendering a response is required, you can just set the status with the ```#head``` method.
      ```#head``` takes a status code as first argument and an optional hash with additional headers as second. You can use the symbols as status code. See the HTTP_STATUS_CODES section in [http://www.rubydoc.info/github/rack/rack/Rack/Utils](http://www.rubydoc.info/github/rack/rack/Rack/Utils) for more details.

      ```ruby
      class TodosController < Volt::HttpController
        def create
        	head :no_content
        end
      end
      ```
   
6. Headers
   You can add custom HTTP headers to your response. The custom headers will be transformed:
   :auth_token will be transformed to 'Auth-Token'. You can either set headers by using a ```Symbol``` or a ```String```. 
   ```:auth_token == 'Auth-Token' == 'auth-token' == 'Auth_Token'```