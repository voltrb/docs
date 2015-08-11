# Usuarios

Los usuarios son un componente muy importante en la mayoría de aplicaciones web. Con el objetivo de ayudar a estandarizar la creación de usuarios, volt ha creado el concepto de usuarios dentro del framework.

## Nota

La implementación de usuarios en volt todavía es un trabajo en progreso.  A futuro queremos añadir soporte para [omniauth](https://github.com/intridea/omniauth) con el objetivo de que el usuario pueda autenticarse a traves de otros servicios. Por ahora solo podemos autenticarnos ingresando el email/usuario y un password.

## Trabajando con usuarios

Volt viene con la gema [volt-user-tempates](https://github.com/voltrb/volt-user-templates).  Primero aprenderemos como usar los usuarios, luego hablaremos acerca de como crear tu propia página de signup y login.

```volt-user-templates``` nos proveé los templates de signup y login que serán renderizados en la ruta del template main. Volt proveé rutas de ```/signup``` y ```/login``` en ```routes.rb```, o puedes cargar los templates usando un tag. Mira el [readme de volt-user-templates](https://github.com/voltrb/volt-user-templates) para mas información.

Puedes acceder al modelo del usuario actual por medio de ```Volt.current_user```.

## Restringiendo Modelos

Volt provee helpers que nos ayudan a asegurarnos de que ciertos datos puedan ser modificados solo por usuarios específicos. Mira [permisos](#permissions) para obtener mas información.

## Logging In

Puedes autenticar un usuario con el siguiente comando:

```ruby Volt.login(login, password) ```

En el ejemplo anterior, ```login``` puede ser el nombre de usuario o el email que se encuentra en la configuración. ```Volt.login``` retorna una [promesa](http://opalrb.org/blog/2014/05/07/promises-in-opal/) la cual se resuelve cuando el login ha sido exitoso, o falla con un mensaje de error cuando el login ha tenido un error.

```ruby
Volt.login(email, password).then do
  # redirect on successful login
  go '/dashboard'
end.fail do |error|
  # login failed with an error
  flash._errors << error
end
```

## Loggin Out

Puedes cerrar la sesión de un usuario de la siguiente manera:

```ruby
Volt.logout
```

La llamada a este método retorna inmediatamente y activa un evento
en ```Volt.current_user``` .

## Creando Usuarios

Para un ejemplo de como crear usuarios, mira [volt-user-templates](https://github.com/voltrb/volt-user-templates).

Volt proveé ```Volt::User``` el cual puede ser heredado por cualquier clase. Por defecto, Volt provee un modelo User en ```app/main/models/user.rb```.

```Volt::User``` usa el ```email``` por defecto como propiedad de login, pero también puedes cambiar la configuración para que pueda usar el nombre del usuario: ```username```. Para hacer esto entra al archivo ```config/app.rb``` y añade:

```ruby
config.public.auth.use_username = true
```

```Volt::User``` nos proveé validaciones en ```email``` o ```username```.  La contraseña se guardará dentro de la propiedad ```password```. Los passwords se guardarán (por medio de hashing) usando [bcrypt](https://github.com/codahale/bcrypt-ruby) en la variable ```hashed_password```. No tendrás que usar la variable ```hashed_password``` directamente.

Para crear un usuario, usa la colección store:

```ruby
def index
  self.model = store._users.buffer
end
```

Puedes usar [volt-fields](https://github.com/voltrb/volt-fields) para mostrar cualquier en la creación de usuarios.

## require_login

Volt::ModelController tiene un método ```require_login``` el cual verificará que el usuario se encuentre logeado, y redireccionará a la página de login.  Tambien mostrará un mensaje de autenticación exitosa.

Puedes requerir que el usuario se encuentre autenticado para algunas acciones usando la opción :require_login dentro de before_action

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :require_login

    def index
    end
  end
end
```

También puedes cambiar el mensaje por default en require_login, o puedes dejar el valor de nil si no quieres sacar ningún mensaje flash

```ruby
module Main
  class MainController < Volt::ModelController
    before_action do
      require_login('Login or else')
    end

    def index
    end
  end
end
```
