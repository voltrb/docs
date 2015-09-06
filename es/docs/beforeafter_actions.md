# Filtros Before/After

A menudo en los controladores, cuando estos son renderizados, existe código que se necesita correr antes o después de ciertas acciones. Volt nos provee acciones ```before_action``` y ```after_action```. Puedes configurar estas acciones de la siguiente manera:

```ruby
module Main
  class MainController < Volt::ModelController
    before_action :english_only

    # require login is a method in Volt::ModelController
    before_action :require_login, only: :about

    def index
      # Setup index...
    end

    def about
      # Setup about...
    end

    # Redirect somewhere if they aren't in an english locale
    # (just as an example)
    def english_only
      if `navigator.language` != 'en-US'
        redirect_to '/translations'
        stop_chain # see below
      end
    end
  end
end
```

# stop_chain

Es muy común crear un redirección desde un filtro `before`. Si no quieres continuar con el renderizado puedes llamar al método ```stop_chain``` en una acción y el renderizado se detendrá.

```stop_chain``` lanza una excepción que será tomada por el filtro, por lo que ningun código podra correr despues de que ```stop_chain``` se ejecute.
