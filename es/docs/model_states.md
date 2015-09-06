# Estados del modelo

Por el hecho de que los modelos corren en el cliente siempre existirá una latencia entre el cliente y el servidor, Volt nos provee algunos métodos de estado que nos permiten ver si nuestro modelo esta sincronizado con el servidor. Si guardas el modelo desde un buffer, la promesa retornada por el método save! solo se ejecutará cuando los datos hayan sido guardados en el servidor, por lo que estos métodos de estado nos muestran en gran parte lo que esta pasando.

## Estado Guardado

En cualquier store de modelo (o buffer) puedes llamar al método saved_state y este nos retornará uno de estos estados:

| Estado    | Descripción                                                           |
|-----------|-----------------------------------------------------------------------|
| :not_saved | El modelo no ha sido guardado en el servidor                            |
| :saving    | Los datos del modelo están en proceso de ser guardados                       |
| :saved     | El modelo es guardado en el servidor y los datos se encuentran actualizados   |

## Estado de Carga

| Estado    | Descripción                                                           |
|-----------|-----------------------------------------------------------------------|
| :not_loaded| El ArrayModel no esta cargado, y nada depende del modelo para su carga (este es un estado interno de volt que no verás a menudo) |
| :loading   | ArrayModel se encuentra cargando datos                     |
| :loaded    | Los datos se han cargado y están siendo sincronizados con el servidor    |
| :dirty     | Los datos fueron cargados en algún punto, pero dejaron de sincronizarse con el servidor. Esto puede pasar cuando no existen bindings escuchando activamente los datos o cualquier resultado producido por los datos |

## Ejemplo

Puedes comprobar si un modelo se ha cargado de la siguiente manera:

```html
{{ if todo.load_state == :loading }}
  <p>Loading Todo...</p>
{{ elsif todo.load_state == :loaded }}
  <p>{{ todo.label }}</p>
{{ end }}
```

Volt también nos provee un método para comprobar si el estado de carga es ```:loaded```

```html
{{ if todo.loaded? }}
  <p>{{ todo.label }}</p>
{{ end }}
```

## Renderizado tardío del Modelo

Toma en cuenta de que si creas ```self.model = ``` en un controlador a una promesa, la vista no se cargará hasta que se resuelva la promesa (Mira [Delayed Rendering](docs/delayed_rendering.md) para mayor informacion)

