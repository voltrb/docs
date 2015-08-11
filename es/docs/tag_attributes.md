# Argumentos/Atributos de los tags

Como en otros tags html, también puedes pasar atributos a los tags de Volt.  Estos atributos se convierten en un objeto que es pasado como primer argumento al método initialize del controller. El método initialize estandar de Volt::ModelController asignará el objeto a la variable ```attrs``` el cual puede ser accedida por medio del método ```#attrs```. Esto hace mucho mas fácil el acceder a los atributos guardados.

```html
<:Body>
  <ul>
    {{ _todos.each do |todo| }}
      <:todo name="{{ todo._name }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>{{ attrs.name }}</li>
```

En lugar de pasar los atributos individualmente, también puedes pasar el objeto modelo del controlador al atributo ```model``` del tag.

```html
<:Body>
  <ul>
    {{ _todos.each do |todo| }}
      <:todo model="{{ todo }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>
    {{ _name }} -
    {{ if _complete }}
      Complete
    {{ end }}
  </li>
```
