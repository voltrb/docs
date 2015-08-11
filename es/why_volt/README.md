# Por Qué Volt?

Empece a construir páginas desde 1996. Mi primera aplicación real la creé en 1998. Desde entonces he visto que muchas tecnologías nuevas han sido añadidas al desarrollo web. Cada nueva tecnología nos brinda mayor poder y flexibilidad, pero también agrega complejidad. Incluso para las aplicaciones mas simples, un desarrollador web necesita conocer: html, css, javascript, un framework para el back-end, un framework para el front-end, REST, compilación de assets y mucho más.

La lista de herramientas y nuevas tecnologías puede llegar a ser interminable.  Con el objetivo de construir páginas web de manera mas rápida tenemos que eliminar parte de esa complejidad. Tratamos de solucionar estos problemas en nuestro tiempo libre, pero en cierta forma aun no lo hacemos en el campo del desarrollo web. Por ejemplo, en la mayoria de lenguajes de programación los desarrolladores no tenemos que encargarnos del manejo de la memoria, usualmente no creamos nuestros propios archivos de sistema y tampoco renderizamos el UI manualmente.  Para no lidiar directamente contamos con tecnologías como garbage collection y kits de desarrollo UI que esconden gran parte de la complejidad de estas tareas.

Entender como funciona el garbage collection puede ser útil y convertirte en un mejor programador, pero encargarte manualmente de la liberación y reserva de memoria puede añadir bugs y mayor complejidad.

Volt trata de reducir la complejidad del desarrollo web de la misma forma. Demos un vistazo de como trata de simplificar el proceso de desarrollo.

### Lenguaje de Programación

Hasta hace poco, todo las aplicaciones web se creaban con un lenguaje en back-end que no era JavaScript y usaba JavaScript solo para el front-end.  En la actualidad JavaScript tambien puede usarse como lenguaje de back-end.  La comunidad de node argumenta el hecho de que usar un solo lenguaje tanto en el cliente como en el servidor simplifica mucho el proceso de desarrollo.  El equipo de Volt tambien esta de acuerdo con esto, pero sentimos que el futuro es compilar a Javascript y no utilizarlo directamente como lenguaje de back-end.

Usar el mismo lenguaje tanto en el cliente como en el servidor reduce mucho el esfuerzo mental que se requiere al cambiar de un lenguaje a otro, pero la mayor ventaja es la capacidad de correr el mismo código en ambos lados. Algo que los programadores de node aun no pueden hacer.

### Framework de Front-end y Back-end

Las aplicaciones web en la actualidad cuentan con un framework para el back-end y otro para front-end. Esto al final del día representa dos maneras distintas de realizar lo mismo. Volt es un único framework que corre en el cliente y el servidor al mismo tiempo.

### HTTP y REST

Al usar diferentes herramientas tanto en el cliente como en el servidor, los datos son sincronizados por medio de APIs REST. Volt permite acceder a estos datos por medio del modelo y estos son sincronizados áutomaticamente entre el cliente y el servidor, sin ningún código adicional por parte del desarrollador.

### Componentes Full Stack

La mayor falencia en los stack de desarrollo web es la falta de estandarización entre el servidor y el cliente. Volt ayuda a estandarizarlo corriendo el mismo código tanto en el cliente como en el servidor.
