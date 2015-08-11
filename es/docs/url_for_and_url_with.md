# url_for y url_with

Si necesitas generar urls usando los routes, puedes llamar a los métodos ```url_for``` o ```url_with```

## url_for

```url_for``` toma un hash de parámetros y retorna un url basado en las rutas

El siguiente es un ejemplo de como crear un link para cambiar ```?page=``` en el string del query. Este ejemplo asume que la ruta existe para el controller 'todos'.

```ruby
url_for(controller: 'todos', page: 5)
# => 'http://localhost:3000/todos?page=5'
```

## url_with

```url_with``` es parecido a ```url_for``` con la diferencia de que combina los parámetros que existen actuálmente en una página. En el ejemplo siguiente se asume que los parametros son ```{controller: 'todos'}```

```ruby
url_with(page: 5)
# => 'http://localhost:3000/todos?page=5'
```

Por el hecho de que ```url_with``` es un método de controlador, este también se puede acceder dentro de la vista:

```html
<a href="{{ url_with(page: 5) }}">page 5</a>
```
