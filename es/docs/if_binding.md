# Binding If

El binding ```if``` te da un control básico del flujo en el código.

```html
{{ if some_check? }}
  <p>render this</p>
{{ end }}
```

Los bloques se cierran por medio de ```{{ end }}```.

Cuando se llega al binding ```if``` este verificará si el predicado es verdadero. Si el código retorna ```true``` este ejecutará el código dentro del siguiente bloque. Cualquier cambio en los datos dentro de la condición de ```if``` actualizará a su vez el código cargado.

Los bindings if tambien pueden incluir bloques ```elsif``` y ```else```.

```html
{{ if condition_1? }}
  <p>condition 1 true</p>
{{ elsif condition_2? }}
  <p>condition 2 true</p>
{{ else }}
  <p>neither true</p>
{{ end }}
```

## Unless

Unless también se encuentra incluido en Volt.

```html
{{ unless some_check? }}
  <p>render this when some_check? is false</p>
{{ end }}
```
