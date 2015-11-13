# Objetivos

Volt tiene los siguientes objetivos:

1. La felicidad del desarrollador
2. Eliminar código duplicado entre el cliente y el servidor
3. Sincronización de datos automática entre cliente y servidor
4. Construir aplicaciones como componentes anidados. Los componentes pueden ser compartidos (por medio de gemas), o correrlos como servicios
5. Concurrencia. Volt provee herramientas para simplificar la concurrencia
6. Manejo inteligente de assets
7. Seguridad
8. Rápido, Liviano y Escalable
9. Código base entendible

# Camino a seguir

Muchas de las características principales se encuentran implementadas. Todavía
nos falta un poco para llegar a la versión 1.0, la mayoría con respecto a
modelos.

1. API de datos - Una abstracción que permitirá crear adaptadores para cualquier tipo de base de datos o datastore.
2. Integración Oauth - El plan es integrar omniauth para hacer mas fácil el uso de cualquier proveedor omniauth
3. Migraciones para añadir índices de bases de datos desde Volt
4. Prerenderizado de HTML desde el servidor - El plan es permitir que el servidor renderice el html de una página primero, para luego atarlo al código ruby compilado del cliente una vez que el código se ha cargado
