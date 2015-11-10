# Bindings de Vistas

(Previamente llamados Bindings de Template)

Todos los archivos ```views/*.html``` de las vistas pueden ser renderizados dentro de otras vistas usando el binding ```view```.

```html
{{ view "header" }}
```

El argumento del método ```view``` debe ser un *view path*. Los bindings de vistas y tags buscan las vistas y los controladores de la misma forma.

A veces quisieramos poder predecir las características necesarias para cada parte de nuestra aplicación, pero en el mundo real, a veces las partes de nuestra aplicación que menos esparamos que crezcan lo hacen. Los bindings de vistas y tags nos permiten configurar el código que vamos a reutilizar de nuestras vistas. La ubicación de los códigos de vistas o tags puede ser movido a medida que estos crezcan sin cambiar la forma en la que estos son invocados.

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
| :body     | index.html            | index                | gems/header |
