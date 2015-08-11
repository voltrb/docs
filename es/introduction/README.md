# Objetivos

Volt tiene los siguientes objetivos:

1. La felicidad del desarrollador
2. Eliminar código duplicado entre el cliente y el servidor
3. Sincronización de datos automática entre cliente y servidor
4. Las apps son creadas como componentes anidados. Estos pueden ser compartidos (por medio de gemas) o pueden correrse como servicios
5. Concurrente. Volt provee herramientas que simplifican la concurrencia. La carga de componentes se la realiza en paralelo en el servidor
6. Manejo inteligente de assets
7. Seguridad
8. Rapido, Liviano y Escalable
9. Código base entendible

# Camino a seguir

Muchas de las características principales se encuentran implementadas. Todavía
nos falta un poco para llegar a la versión 1.0, la mayoría con respecto a
modelos.

1. API de datos - Una abstracción que permitirá crear adaptadores para cualquier tipo de base de datos o datastore.
2. Integracion Oauth - El plan es integrar omniauth para hacer mas fácil el uso de cualquier provedor omniauth
3. Migraciones para añadir índices de bases de datos desde Volt
4. Mailers
5. Prerenderizado de HTML desde el servidor - El plán es permitir que el servidor renderice el html de una página primero, para luego atarlo al código ruby compilado del cliente una vez que el código se ha cargado
