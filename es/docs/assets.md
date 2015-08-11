# Assets

## CSS y JavaScript

En Volt, los archivos de assets como JavaScript y CSS (o sass) son incluidos automáticamente. Cualquier archivo que se agregue dentro de los paths assets/js o assets/cs son agregados a /assets/{js,css} (por medio de [Sprockets](https://github.com/sstephenson/sprockets)). Los tags de Link y script son agregados para cada archivo css y javascript respectivamente. Los archivos son agregados en orden léxico, por lo que puedes agregar un numero al principio del archivo si necesitas cambiar el orden con el que se va a cargar.

Cualquier archivo JS/CSS de un componente añadido o de una gema componente también serán incluidos. [Bootstrap](http://getbootstrap.com/) es incluido gracias a la gema volt-bootstrap

### Deshabilitando el auto-import de assets para agregarlos manualmente

Si quieres agregar los archivos de assets manualmente, puedes deshabilitar el auto-import de CSS y JS por componente especificando ```disable_auto_import``` en la parte superior del archivo ```config/dependencies.rb```. Luego puedes incluir archivos CSS y JS para cada componente manualmente usando los helpers que se muestran a continuación.

```disable_auto_import``` solo deshabilita la inclusión automática de JS y CSS. Archivos de tipografía, imágenes y otros assets no se verán afectados.

Por ejemplo, si el archivo ```config/dependencies.rb``` de tu componente luce de la siguiente manera:

```
disable_auto_import
css_file 'manifest.scss'
# font awesome
css_file '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'
javascript_file 'my_js.min.js'
```

Solo el archivo 'manifest.scss', el link CDN para la tipografía y el archivo JS minificado seran incluídos en la página.

##### javascript_file
```javascript_file 'my_js.js'```
Este helper buscará tu archivo en ```app/{component}/assets/js```.

##### css_file
```css_file 'my_scss.scss'```
Este helper buscará tu archivo en ```app/{component}/assets/css```. Puedes usarlo con archivos SCSS o CSS . Usando esto puedes crear un archivo manifest para especificar el orden de carga de los archivos de estilo.

## Imagenes, Tipografías y otros Assets

Es recomendable que las imágenes y otros assets se encuentren ubicados en ```app/{component}/assets/images``` (o fonts, etc..), luego el url para las imágenes será: ```/assets/{component}/assets/images/...```. Las imágenes y otros assets no se verán afectados por ```disable_auto_import```.

**Nota: asset building se encuentra todavía en construcción**
