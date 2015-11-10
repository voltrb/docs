# Binding Yield

Cuando uses [Tags](#tags), el contenido de la página se puede pasar entre los tags de la siguiente manera:

```html
<:nav href="/about">About</:nav>
```

En el ejemplo anterior, "About" puede cargarse en otro lugar usando ```{{ yield }}```. El siguiente es un ejemplo de como usar un tag para cargar una sección.

```html
<:Nav>
    <li>
        <a href="{{ attrs.href }}">{{ yield }}</a>
    </li>
```

Cualquier contenido u otros bindings pueden ser pasados a un ```tag```. También puedes pasar contenido al tag de un componente y hacer yield dentro de sus vistas.

Por último, si solo quieres obtener el contenido html como un string, puedes llamar al método ```yield_html``` en el controlador. Esto retornará un string en el cual puedes invocar el método ```.watch!``` en el caso de que lo necesites y este cargará de nuevo el contenido en el caso de que existan cambios.

