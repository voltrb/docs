# Permisos

Por defecto, los modelos en Volt pueden ser leídos o editados por cualquier usuario, pero si quieres usar restricciones Volt permite hacerlo fácilmente.  El API de permisos de Volt esta dividido en cuatro diferentes acciones: create, read, update, delete (o CRUD)

Puedes especificar permisos dentro de un modelo de la siguiente manera:

```ruby
class Todo < Volt::Model

    permissions do
      # .. permissions logic ..
    end
end
```

## Lógica de permisos

El bloque de código agregado a permisos es llamado cuando una de las acciones CRUD es llamada en el modelo. Dentro del bloque de permisos puedes usar ```allow``` y ```deny``` para restringir permisos, luego la acción es bloqueada en su totalidad.  También puedes pasar una lista de campos como argumento, luego la acción será bloqueada para esos campos. Cuando corras ```self``` dentro del bloque de permisos este llamará al modelo actual.

```ruby
class Todo < Volt::Model
  permissions do
    deny :label
  end
end
```

## Own by User

Puedes usar el método ```own_by_user``` para asignar automáticamente el campo ```user_id``` al usuario logeado cuando un modelo es creado (mira [Usuario](http://docs.voltframework.com/en/docs/users.html) para mas información). Este también configurará el método belongs_to: user ( u opcionalmente otro llave para ser usada como ```user_id```).

Si un modelo pertenece a un usuario, puedes comprobar si el usuario conectado es el dueño de este llamando (dentro del bloque permissions) al metodo ```.owner?``` . Este retornará verdadero si el usuario actual es es el dueño.

```ruby
class Todo < Volt::Model
  own_by_user

  permissions do
    deny unless owner?
  end
end
```

El código anterior no permitirá que otros usuarios puedan crear, leer, actualizar o borrar este modelo (```.owner?``` retornará verdadero dentro de create porque el ```user_id``` será asignado automáticamente por ```own_by_user``` )

### Allow vs Deny

Una ves que allow ha sido especificado el resto de campos se bloquearán.

```ruby
class Todo < Volt::Model
  permissions do
    allow :label, :complete
  end
end
```

^  solo los campos label y complete seran permitidos, el resto serán bloqueados.  Al usar ```permission``` sin ningún argumento este configurará los permisos para todas las operaciones CRUD (create, read, update, delete). Para restringir solo ciertas acciones tienes que pasarlas como argumentos al método ```permissions```.  También puedes especificar múltiples bloques de permisos.

```ruby
class Todo < Volt::Model
  permissions(:create, :update) do
    deny :notes, :secret_notes unless owner?
  end

  permissions(:read) do
    deny :secret_notes unless owner?
  end

  permissions(:delete) do
    deny unless owner?
  end
end
```

^  El código anterior permitirá al propietario cambiar los campos ```notes``` y ```secret_notes```, pero los otros campos pueden ser cambiados por cualquier usuario. Solamente el propietario puede leer el campo ```secret_notes``` (mientras los campos restantes podrán ser leídos por cualquiera). Por último, solo el propietario puede borrar cualquier campo del modelo

### Pasando la acción

También puedes pasar la acción como un argumento dentro del bloque. Este representará la acción que se encuentre corriendo.

```ruby
class Todo < Volt::Model
  permissions(:read, :update) do |action|
    if action == :read
        allow
    else
        deny unless owner?
    end
  end
end
```

### Ignorando Permisos

Si al usar ```allow``` tu lógica se vuelve muy compleja siempre podrás solo negar los campos necesarios, para luego modificarla mediantes un task. Por ejemplo, al crear un flag ```admin``` en el modelo podrás negar actualizaciones a este campo y luego podrás configurar un usuario como admin ignorando los permisos.

```ruby
class User < Volt::User
  permissions(:create, :update) do
    # make it so no one can update without skipping permissions
    deny :admin
  end
end
```

Puedes ignorar los permisos corriendo este método ```Volt.skip_permissions``` y luego pasando un bloque. El método ```skip_permissions``` solo puede correrse desde el servidor, por obvias razones.

```ruby
Volt.skip_permissions do
  # Running without permission checks.
  # Set admin
  user._admin = true
end
```

### Resumen

El API de permisos proveé una manera muy simple para definir quien puede hacer que con los datos de tu aplicación. Puedes ingresar la lógica que tu deseés dentro de los bloques de permisos.
