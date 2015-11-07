# Soporta Volt Haml, Slim..

Actualización: Si, volt cuenta ahora con soporte para slim, gracias a @ASnow: https://github.com/asnow/volt-slim

Todavía no contamos con soporte para HAML, a continuación una breve explicación del porque y que es necesario hacer

Esta es una pregunta muy común sobre todo por parte de quienes han usado Rails , donde resulta muy fácil añadir soporte para varios lenguajes de templating.  En Rails el renderizado de un template toma la ubicación del template y un objeto, el cual se usará como contexto. Luego el resultado se genera como un string.

En volt, por el contrario, los templates primero se renderizan como un template compilado que puede ser enviado al cliente. Los templates no son generados como strings, son contruidos para un escenario específico. Volt contempla dos escenarios:

- El dom
- Un string (para renderizar parte de los templates en tags, email o html usado en el servidor)

# Entonces que hace falta para poder renderizar con Haml, etc...

No todo es malas noticias, pero haml y slim no fueron diseñados exactamente para las necesidades de volt en mente. Cualquier lenguaje de template que puede compilar el código al formato generado por volt puede ser usado.  El formato del template es código ruby (el cual es compilado hacia el cliente por medio de Opal). Este consiste de html y bindings. El html contiene placeholders (por ahora comentarios especiales de html) que nos muestran donde deben ser generados los bindings. Los bindings son ruby Procs que muestran el tipo de binding que representan. (Volt::EachBinding, Volt::ContentBinding, Volt::AttributeBinding, Volt::IfBinding y Volt::EventBinding)

Para lograr compilar a haml o slim, necesariamente se debe modificar el código fuente de cualquiera de los dos para que puedan compilar al formato especial de volt. Si estas interesado en ayudar puedes contactarte con @ryanstout o por medio de [gitter](https://gitter.im/voltrb/volt).
