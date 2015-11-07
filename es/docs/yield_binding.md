# Binding Yield

Cuando usas [Tags](#tags), el contenido que es generado al momento de llamarlo sera pasado en la definición de este tag.
En otras palabras, la definición del tag podrá hacer referencia al contenido del 'caller', el cual tiene casi el mismo que el
keyword `yield` en ruby.

Supongamos que tenemos un elemento del navbar que queremos reutilizar, en nuestro caso una simple elemento de una lista:

```html
<li>
  <a href="/about">
    <span class="nav_element"> About </span>
  </a>
</li>
```

Podemos convertir este pedazo de html en un tag fácilmente, incluso podemos pasar el link y el texto de este por
medio de ```attrs```, aunque no seria del todo intuitivo hacerlo para el texto dentro de span, en este caso podemos
usar el binding yield:

```html
<:Nav>
  <li>
    <a href="{{ attrs.href }}">
      <span> {{ yield }} </span>
    </a>
  </li>
```

Para usar el output de este tag en nuestra página, lo hariamos con el siguiente tag:

```html
<:nav href="/about">About</:nav>
```

En el ejemplo anterior, "About" se cargara en lugar ```{{ yield }}```. Por lo general, cualquier contenido dentro del tag que llama a la definición se encargara de ligar ```yield```

Por último, si solo quieres obtener el contenido html como un string, puedes llamar al método ```yield_html``` en el controlador. Esto retornará un string en el cual puedes invocar el método ```.watch!``` en el caso de que lo necesites y este cargará de nuevo el contenido en el caso de que existan cambios.
