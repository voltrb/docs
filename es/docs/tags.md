# Tags

Tags (formalmente llamados controls) te permiten renderizar una vista/controlador de forma similar a como se renderiza un view binding. La principal diferencia es que con tags puedes enviar atributos como argumentos.

Los tags empiezan con un ```:``` (colon) para diferenciarlos de tags html normales. Al igual que los tags html normales, estos deben ser cerrados.

```html
<:tag_name />
```

o

```html
<:tag_name></:tag_name>
```

Revisa la sección bindings de vistas para saber como los tags buscan las vistas asociadas. El código anterior tiene el mismo lookup que ```{{ view "tag_name" }}```.  Llamar al método ```<:blog:comments />``` es equivalente a ```{{ template "blog/comments" }}```

Un tag se carga igual que un template, llamando al controlador, llamando al método de la acción (si existe) y cargando la vista. También puedes pasar atributos a los tags
