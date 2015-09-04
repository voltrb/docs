# Introducción

Volt es un web framework donde tu código Ruby corre tanto en el servidor como en el cliente (por medio de [opal](https://github.com/opal/opal)). El DOM se actualiza al mismo tiempo que el usuario interactua con la página. El estado de la página puede ser guardado en el url. Si el usuario ingresa la url directamente, el HTML se carga primero en el servidor (para una carga mas rápida y una mejor indexación en motores de busqueda) para luego ser manejada en el cliente.

En lugar de sincronizar los datos entre el cliente y el servidor por http, Volt usa una conección permanente. Cuando los datos son actualizados en un cliente específico estos cambios se reflejan tanto en la base como en otros clientes (sin ninguna configuración adicional).

El HTML se escribe en un lenguaje de templating donde puedes ingresar código ruby entre ```{{``` y ```}}```. Volt usa programación reactiva para propagar automáticamente los actualizaciones al DOM (o cualquier parte del código que necesita saber cuando los datos han sido cambiados). Cuando una parte del DOM cambia, Volt actualiza solo los nodos que necesitan ser actualizados.

Adicional a la documentación, puedes obtener mas ayuda en los siguientes videos:

- [Volt Todos Example](https://www.youtube.com/watch?v=KbFtIt7-ge8)
- [What Is Volt in 6 Minutes](https://www.youtube.com/watch?v=P27EPQ4ne7o)
- [Pagination Example](https://www.youtube.com/watch?v=1uanfzMLP9g)
- [Routes and Templates](https://www.youtube.com/watch?v=1yNMP3XR6jU)
- [Isomorphic App Development - RubyConf 2014](https://www.youtube.com/watch?v=7i6AL7Walc4)

O revisa las aplicaciones de demostración:
 - https://github.com/voltrb/todomvc
 - https://github.com/voltrb/blog5

