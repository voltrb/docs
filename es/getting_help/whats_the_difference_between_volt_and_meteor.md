# Cual es la diferencia entre Volt y Meteor?

Volt y Meteor son similares en muchas formas, principalmente por que ambos tratan de solucionar los mismos problemas. Aparte del hecho de que Volt usa Ruby y Meteor JavaScript, existen otras diferencias:

## Componentes

Una de las grandes diferencias es que volt construye aplicaciones como componentes.  Creo que esto hace mas fácil la reutilización de código (como gemas), y obliga a que nuestras aplicaciones sean mas modulares. Esto también significa que puedes crear "limites definidos" para la carga de páginas, con el objetivo que crear tu aplicación como múltiples aplicaciones single page. Así no tendrás que cargar todo la aplicación en el cliente la primera vez que cargas la página. Puedes tener partes donde el navegador hace un get request normal para cargar otras secciones.

## El cliente y el acceso a la Base de Datos

En meteor trabajas con la base de datos directamente (para insertar, crear, etc..), en volt, por el contrario, trabajas con objetos. Puedes crear clases que hereden de Volt::Model y basado en como estos estén configurados, los objetos pueden ser guardados en distintos lugares. Ya que los objetos no tienen que ser persistidos necesariamente (como en un repositorio, por ejemplo), puedes probarlos de forma aislada.  Esto también nos proveé un lugar en común para poner toda la lógica del negocio relacionada con el objeto y prevenir que esta lógica (validaciones/permisos) pueda ser violentada.

## Manejo de Datos

Otra gran diferencia es la manera como se manejan los datos. Meteor te hace decidir de antemano que datos usará el cliente cuando la página se carga (por medio de publicaciones).  Luego te suscribes a la fuente de datos en el cliente. A pesar de que puedes pasar opciones al publicar vía suscripciones, es un proceso complicado en mi opinión. La principal razón para hacer esto es para trabajar con los datos en el cliente sin tener que esperar por un callback. El problema con esto es que existen muchos casos en los que necesitas esperar unar respuesta del servidor. Un buen ejemplo son las validaciones, las cuales necesitan llegar al servidor para ser revisadas. En Volt, los datos se cargan reactivamente para todo aquello que este siendo observado. Acciones como guardar retornan una promesa, en caso de que necesites esperar un resultado. Tenemos planeado agregar extensiones para Opal similares a las de iced coffescript para tener una mejor sintaxi (con el objetivo de hacer el api transparente y síncrono). Algo que he notado es que las aplicaciones actuales en meteor han dejado de usar mini-mongo en el cliente y han empezado a usar métodos de meteor para todo.  Creo que esto muestra que meteor esta teniendo dificultades con la manera en la que mongo maneja los datos. Otro cosa que he notado es que demasiada cantidad de datos es enviada al cliente (porque es difícil saber que datos se necesitarán al momento de ser cargados). No estoy diciendo que la solución de volt es perfecta, pero creo que solventa estos problemas de mejor manera que meteor.

## Otras diferencias

Este es un vistazo rápido de otras diferencias:

- Volt usa convenciones y estructura de archivos mas que Meteor
- El router de Volt es completamente diferente
- Volt no tiene $31MM en inversiones :-)
