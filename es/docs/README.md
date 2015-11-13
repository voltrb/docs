# Documentación

Lo siguiente pretende documentar todo las características implementadas en Volt.
Aunque el código fuente será siempre la principal fuente para obtener información
al día, tratamos de mantener esta documentación lo mas actualizada posible.

## Layout de un app

Una nueva aplicación de volt se crea por default con los siguientes archivos/carpetas:

| nombre          | descripción                                                      |
|-----------------|------------------------------------------------------------------|
| app             | Contiene los [componentes](docs/components.md) del app en sub-carpetas |
| config          | Contiene la configuración de la aplicación, y código para ejecutar en el arranque del app (initializers) |
| config.ru       | Un archivo especial usado por servidores compatibles con [rack](http://rack.github.io/) para arrancar la aplicación |
| spec            | Carpeta que contiene los specs |
| Gemfile         | Especifica todas las gemas del proyecto |
| Gemfile.lock    | Archivo generado por [bundler](http://bundler.io/) el cual hace seguimiento de los números de versiones específicos de las gemas |
| README.md       | Un archivo markdown para tu proyecto |

La mayor parte del código de tu aplicación se dividirá en folders de componentes dentro de tu aplicación. Las apps generalmente se pueden dividir en
componentes separados, lo cual nos ayudará a tener un código mas testeable y mantenible.
Por default, volt genera un componente llamado "main". Si recién estas empezando a usar volt, puedes poner todo tu código dentro de "main".

### Componentes

Los componentes contienen otras carpetas con contenido standard

| nombre          | descripción                                                      |
|-----------------|------------------------------------------------------------------|
| assets          | tus assets estáticos: css, js, image, font, etc...               |
| config          | configuración específica y manejo de dependencias de un componente |
| controllers     | Clases que orquestan la presentación en UI y lo conectan con los modelos |
| lib             | Código ruby adicional, el cual será usado en el componente |
| models          | Clases que manejan los datos, permisos, validaciones y lógica del negocio |
| views           | Archivos html representan la vista de nuestra aplicación |

La siguiente sección de la documentación hablara con mas detalle acerca de cada una de las partes de un componente
