# Componentes

Las aplicaciones en Volt estan compuestos por componentes. Casa folder dentro de ```app/``` es un componente. También puedes incluir componentes como gemas. Las apps generalmente se subdividen en pequeños componentes. Un componente puede ser cualquier cosa, desde pequeños widgets reusables hasta apps mucho mas complejas.  Gracias a que los componentes pueden ser agregados en otros componentes recomendamos empezar con uno pequeño para luego construir componentes mas grandes. Los componentes que pueden ser reusados pueden construirse como [gemas de componente](docs/component_gems.md), o puedes mover el componente a una gema cuando lo desees.

El código dentro de un componente puede ser accedido de algunas maneras. El código de un modelo es accesible desde cualquier lugar dentro de la aplicación. Las vistas/controladores pueden ser accedidos usando tags o enlaces de vistas.  Mira [tags](docs/tags.md) para mas información sobre como funciona el acceso a los paths de las vistas.

La idea general de un componente es la de mantener partes de tu código aisladas y que de esta manera pueden ser probadas y desarrolladas independientemente.

Algunos ejemplos de componentes pueden ser los siguientes:

__Widgets__
- Un campo con validaciones
- Un slider
- WYSIWYG editor
- Carga de archivos
- Mapas de Google

__Paginas__
- pagina de login
- paginas de signup/login/forgot password

__Partes de una Aplicación__
- blog
- cms
- area de manejo para administrador

Una buena regla es la de usar mas componentes de los que puedas necesitar, ya que separar tus apps no es algo muy difícil de hacer.

## Crea un componente

Puedes agregar un nuevo componente a una aplicación por medio del siguiente comando:

```bundle exec volt generate component NAME```

## Componentes y routing

Cuando visitas una ruta esto carga todos los archivos del componente en el frontend, asi las páginas dentro de ese componente no tendrán que cargarse mediante un request HTTP. Si el URL visitado apunta a un componente diferente el request se ejecutará como una página normal y cargará todos los archivos de este componente. Puedes pensar en los componente como los 'límites de recarga' entre secciones de tu aplicación. [Nota: Por ahora solo el componente 'main' es soportado para la carga inicial de página, muy pronto añadiremos 'límites de recarga' para otros componentes]
