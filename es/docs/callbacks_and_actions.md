# Acciones de Controlador

Cuando un binding o un tag renderiza una vista lo primero que se carga es el controlador. Existen cuatro callbacks para el renderizado. La acción tiene el mismo nombre que la vista, por lo que si renderizas la página ```about.html``` , la acción se llamará ```about```. Simplemente tienes que crear el método correcto en el controlador y será llamado en el momento indicado.

| nombre acción           | descipción |
|-----------------------|-----------------------------------------------------|
| callbacks before_action | Si ```stop_chain``` es invocado la acción no será llamada y se parará la ejecución. |
| ```{action}``` | Es llamado antes de que cualquier cosa se renderize, aquí puedes inicializar los datos que necesites |
| callbacks after_action | las acciones after_action's no pueden llamar a ```stop_chain``` (al ser llamados solo lanzan una excepción) |
| ```{action}_ready``` | Se lo llama despues de que las vistas se han cargado.  Puedes correr código en el cual tienes que manipular directamente el DOM.  por ejemplo para configurar código jQuery (componentes bootstrap) |
| ```before_{action}_remove``` | Es llamado antes de que la vista se removida. Aqui puedes limpiar enlaces que tengas con el DOM. |
| ```after_{action}_remove``` | Llamado despues de que la vista es removida del DOM. Puedes limpiar cualquier cosa que necesite ser limpiada en el controlador. |

La mayor parte del tiempo lo único que necesitarás es el método de la acción para configurar el controlador, modelo, etc...
