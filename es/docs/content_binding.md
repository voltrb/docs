# Binding de contenido

El binding mas básico es el siguiente:

```html
<p>Hello {{ name }}</p>
```

El contenido de estos bindings corren código ruby entre ```{{``` y ```}}```, luego renderiza el valor retornado. Cuando los datos en un binding de contenido dependen de los cambios, el binding correrá nuevamente y actualizará el texto. El texto dentro del binding es escapado por defecto.
