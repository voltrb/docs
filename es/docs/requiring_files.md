# Requiriendo Archivos

Si tienes un archivo llamado `my_awesome_app/app/main/mixins/my_file.rb`, donde `my_awesome_app` es la dirección root de tu aplicación, y `main` es el componente en el cual se encuentra nuestro archivo, podemos añadirlo en otro archivo de la siguiente forma:

```ruby
require "main/mixins/my_file"
```

El path debe comenzar con el nombre de la carpeta del componente
