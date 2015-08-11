# Obteniendo los nodos DOM de las vistas

Aunque puedes hacer muchas cosas con los bindings provistos por Volt, a veces es necesario modificar directamente el DOM de la vista. Existen dos formas para trabajar directamente con el DOM:

- Por donde empezar
- Obteniendo el container

## Por donde empezar

Gracias a que Volt renderiza las páginas automáticamente en el cliente, no puedes usar ```$(document).ready``` directamente en jQuery. (Nota: Volt incluye jQuery por default, si quieres usarlo), puedes usar el método {action}_ready method para la página específica que quieres usar. (Mira [Callbacks y Acciones](callbacks_and_actions.md) para mayor información). Probablemente tendrás que dividir tus vistas para obtener los triggers de cada uno.

## Obteniendo el nodo DOM

A diferencia de otros framework, las vistas en Volt pueden tener múltiples nodos en la raíz

```html
<:Item>
    <td>{{ label }}</td>
    <td><a href="/edit/{{ id }}">Edit</a></td>
```

### Rangos Dom para las vistas

En el código siguiente, no podemos simplemente preguntar por el 'nodo' de la vista. Para esto volt usa [Rangos Dom](https://developer.mozilla.org/en-US/docs/Web/API/Range) para representar los nodos dentro de la vista. Puedes obtener rangos para los nodos de la vista llamando al método ```dom_nodes``` en el controlador

### Contenedor de nodos

Trabajar con rangos DOM puede llegar a ser complicado, ya que muchas librerías (jQuery, por ejemplo) son usadas para trabajar con nodos. Para obtener el nodo mas cercano, el cual contiene toda la vista puedes llamar al método ```container``` en el contralador.

## Primer Elemento

En el ejemplo anterior (el que tiene dos elementos td), el método container nos retornará una tabla, el cual es el único nodo común en un ejemplo con mas de un nodo "root" en la vista. Si tienes un único root, como en la siguiente vista:

```html
<:Post>
    <section>
        <h1>{{ title }}</h1>
        <p>{{ body }}</p>
    </section>
```

En el ejemplo anterior, el tag tiene un único nodo root para toda la vista.  Aunque por los espacios podemos deducir que existen mas nodos, por lo que el metodo ```container``` nos retornará el nodo dentro de section. Si sabes que solo tienes un nodo en la vista puedes usar el método ```first_element``` para obtener el primer nodo de la vista. (Un elemento nodo también puede ser un tag)
