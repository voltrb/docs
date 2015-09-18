# Que navegadores son compatibles con Volt?

Descartando Firefox y Chrome, los cuales siempre están actualizados, seguramente te preguntarás por IE. La buena noticia es que opal soporta IE desde la versión 6. Volt solo soporta la versión 10 de IE por el momento, pero estamos trabajando en la gema volt-ie8to9 que dara soporte a las versiones 8 y 9. Lo único que nos falta es un fallback para websockets.

## Características limitadas

Existen algunas características de Volt que solo funcionan para ciertos navegadores

1) Binding de campos ocultos.
Para crear un bind en un campo oculto, el navegador necesita eventos mutables observer. Estos solo se encuentran soportados para >=IE11. Existe un polyfill que puede ser usado para obtener soporte en IE8-10, para el cual crearemos un gema muy pronto
