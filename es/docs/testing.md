# Testing

Volt usa rspec para las pruebas, pero puedes cambiar a otra librería de testing removiendo todo las gemas relacionadas con rspec en el Gemfile de tu proyecto. La mayoría de generadores crearán tests de prueba para que puedes empezar a escribir tus propios tests.

La convención en Volt es tener la misma estructura del directorio app en la carpeta spec, así cada componente tendrá su carpeta dentro de spec. Si cargas el archivo spec-helper ```require 'spec-helper'``` en tu test, puedes correr ```bunde exec rspec``` para correr todos tus tests o puedes incluir el path para correr un test específico.  (Nota: Volt no usa rake por defecto, por lo que los tests se corren con directamente con rspec).

# Helpers

Volt nos proveé con métodos dentro de los specs para acceder a la página ```page``` y a la colección ```store```. Por un conflicto con capybara el método para acceder al método ```page``` dentro de rspec es ```the_page``` (estamos trabajando en una solución para esto).

Puedes acceder al store llamando al método ```store``` en un spec.  Si ```store``` es llamado después de correr los tests la base de datos se limpiará automáticamente. Esto facilita el no tener que configurar el limpiado de la base de datos para cada test.

# Pruebas de Integración

Volt provee rspec y capybara por default. Puedes también probar tus modelos, controladores, etc.... o puedes crear pruebas de completas de integración por medio de capybara.

Para hacer que un spec corra en capybara, simplemente añade
```type: :feature``` dentro del bloque 'describe' del test

```ruby
describe "browser specs", type: :feature do
  it ...
end
```

Las pruebas de integración no corren por default, para correr los tests de capybara tienes que especificar un driver. Los siguientes drivers son soportados:

1. Phantom (por medio de poltergeist)

```BROWSER=phantom bundle exec rspec```

2. Firefox

```BROWSER=firefox bundle exec rspec```

3. IE - muy pronto

Chrome no es soportado por este [problema](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges)h en ChromeDriver.

