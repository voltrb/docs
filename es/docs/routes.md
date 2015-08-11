# Rutas

Las rutas en Volt son muy diferentes a las de otros frameworks. Ya que los datos son sincronizados con el cliente por medio de websockets, las rutas son usadas por dos razones. Volt provee dos tipos de rutas en un mismo archivo: rutas ```client``` y rutas http (```get```, ```post```, ```put```y ```delete```)

## Rutas Cliente

Para serializar el estado de una aplicación en el url de una manera lógica, cuando una página es cargada por primera vez, el url es parseado con las rutas y los valores para los parametros del modelo son tomados y configurados desde el URL. Luego, si los parámetros del modelo son actualizados el URL es actualizado en base a las rutas.

Esto significa que las rutas en Volt tienen que ser capaces de ir desde el URL a los params y desde los params al URL. También hay que tomar en cuenta que si se accede a un link y el controlador/vista para cargar la nueva url se encuentra en el componente actual (o en un componente incluido), la página no se reiniciará, la URL se actualizará por medio de HTML5 history API, y el hash de parámetros se actualizará para reflejar el nuevo URL. Puedes usar los cambios en los parametros para cargar distintas vistas basadas en un URL.

## Rutas HTTP

Con el objetivo de proveer datos a los clientes estos deben ser accedidos por medio de Http (un api REST, por ejemplo).

