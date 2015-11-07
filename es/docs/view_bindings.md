# Bindings de Vistas

(Previamente llamados Bindings de Template)

Todos los archivos ```views/*.html``` de las vistas pueden ser renderizados dentro de otras vistas usando el binding ```view```.

```html
<h1>Header stuff</h1>

{{ view "header" }}
```

Si el archivo de header luce de la siguiente manera:

```html
<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
</ul>
```

Cuando el archivo original se cargue se verá de la siguiente manera:

```html
<h1>Header stuff</h1>

<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
</ul>
```

(Nótese que el binding de vista fue reemplazado con el contenido del archivo "header")

El argumento del método ```view``` debe ser un *view path*. Los bindings de vistas y tags buscan las vistas y los controladores de la misma forma.

A veces quisieramos poder predecir las características necesarias para cada parte de nuestra aplicación, pero en el mundo real, a veces las partes de nuestra aplicación que menos esparamos que crezcan lo hacen. Los bindings de vistas y tags nos permiten cargar controladores y vistas sin tener que preocuparnos si el código se encuentra en la misma carpeta de la vista, en un componente o en una gema. La ubicación de los códigos de vistas o tags puede ser movido a medida que estos crezcan sin cambiar la forma en la que estos son invocados.

Hechemos un vistazo a los paths de una vista de ejemplo.

```html
{{ view "header" }}
```

Dado el string "header", Volt buscará el archivo de la vista en los siguientes ubicaciones (en orden):

| Sección   | Archivos de Vistas    | Carpeta de Vistas    | Componente  |
|-----------|-----------------------|----------------------|-------------|
| header    |                       |                      |             |
| :body     | header.html           |                      |             |
| :body     | index.html            | header               |             |
| :body     | index.html            | index                | header      |
| :body     | index.html            | index                | {gems}/header |

Una ves que se encuentra la vista, el controlador asociado con esta sera cargado primero. El controlador para un
archivo de vista siempre será {algo}_controller.rb, donde {algo} es el nombre de la carpeta donde esta
nuestra vista. (Nota, las vistas deben estar ubicadas en {componente}/views/{algo}.html - En volt no se
crean subcarpetas dentro de la carpeta view).

Volt revisa lo siguiente en orden hasta encontrar una vista:

1. **Sección** - los archivos de vista (eg.something.html) estas compuestos por secciones. Las secciones empiezan
asi ```<:SectionName>``` y no se cierran. Volt primero buscará una sección en la misma vista y usara el html
definido en esta sección si encuentra una.

2. **Vistas** - luego, Volt buscará un archivo de vista en la misma carpeta del archivo sobre el cual se esta
llamando el binding de vista. Si se encuentra, este cargará la sección **Body** de esta vista.

3. **Folder de Vista** - Si lo anterior falla, Volt buscará una carpeta de vista con un nombre que concuerde (esta
carpeta debe incluir un archivo index.html). Una ves encontrado cargará la seccion **Body** de esta vista, en el
caso de que exista un controlador para esta vista

4. **Componente** - luego, se buscará todas las capetas dentro de app/. El path de la vista sobre la cual se hará
la busqueda sera ```{component}/index/index.html```, el cual debe incluir una sección :body

5. **Gemas** - por último, se revisa la carpeta app de todas las gemas que empiecen con ```volt-```. También se revisan
paths similares en componentes

Hay que tomar en cuenta que cada ves que se carga una vista, una nueva instancia de controlador es creada para esa
vista.

Cuando creas un binding de vista, también puedes especificar múltiples partes en el path del nombre. Las partes deben
estar separadas por un slash ```/```. Por ejemplo:

 ```html
     {{ view "blog/comments" }}
 ```

 Lo anterior buscara lo siguiente:

 | Section   | View File    | View Folder    | Component   |
 |-----------|--------------|----------------|-------------|
 | :comments | blog.html    |                |             |
 | :body     | comments.html| blog           |             |
 | :body     | index.html   | comments       | blog        |
 | :body     | index.html   | comments       | gems/blog   |

Una ves que se encuentre el archivo (o sección) para esa vista, Volt buscara el controlador respectivo. Si no se
encuentra un controlador para esta vista se creara un nuevo ```ModelController```. Una ves que se carga el controlador
se llamará la acción correspondiente (si es que existe). El nombre de estas acciones son por defecto el nombre del
archivo de la vista, - mira [Callbacks and Acciones](callbacks_and_actions.md) para obtener mayor información.

## Options

### Grupo del Controlador

La opción `:controller_group` en los bindings de vistas hace posible el compartir una misma instancia de controlador entre varias vistas. Normalmente, cuando creamos una vista, esta será creada con su propio controlador, pero cuando dos o mas bindings de vistas usan el mismo parámetro en `controller_group` estas empezarán a usar un misma instancia de controlador.
