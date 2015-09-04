## Colecciones Proporcionadas

Hemos mencionado que Volt nos proveé con varios tipos de colecciones, las cuales se pueden acceder desde el controlador.

| Nombre        | Ubicación de Almacenamiento                                                   |
|-------------|--------------------------------------------------------------------|
| page        | Almacenamiento temporal de la página, esta disponible mientras no se cierre la página actual.        |
| store       | Sincroniza los datos con la base de datos de backend y nos proveé métodos de consulta. |
| local_store | Almacenamiento temporal del browser.                                  |
| params      | Guarda los valores en params y dentro de la estructura del URL.  Las rutas pueden ser configuradas para cambiar como son mostradas en el URL.  (Mira la documentación de rutas para mayor información) |
| flash       | Cualquier string asignado a esta colección sera mostrada en la parte superior de la página, y luego será eliminada al cambiar de página. |
| cookies     | Guarda cada valor en un cookie. Puedes asignar propiedades directamente, pero no lo puedes hacer dentro de subcolecciones |
| controller  | Un modelo para el controlador usado.                                       |

Se agregarán mas colecciones muy pronto.
