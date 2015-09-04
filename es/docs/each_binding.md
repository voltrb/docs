# Each binding

Para iterar objetos, puedes usar ```.each```

```html
{{ _items.each do |item| }}
  <p>{{ item }}</p>
{{ end }}
```

Si ```_items``` es un arreglo, el bloque se renderizará para cada item en el arreglo, definiendo ```item``` como el elemento actual del arreglo.

También puedes llamar al método ```.each_with_index``` para llamar al índice actual dentro del bloque

```html
{{ _items.each_with_index do |item, index| }}
  <p>{{ index }}. {{ item }}</p>
{{ end }}
```

Para el arreglo ```['one', 'two', 'three']``` se imprimirá lo siguiente:

    0. one
    1. two
    2. three

Puedes usar ```{{ index + 1 }}``` para eliminar el cero y obtener el índice correcto

Cuando los items son añadidos o removidos de un array, el binding ```each``` automáticamente actualizará el DOM.
