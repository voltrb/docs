# Despliegue de aplicaciones volt

Cuando deployas una aplicación, se recomienda que corras volt con al opción VOLT_ENV=production. Esto deshabilitará

el reloading automático del código, sourcemaps y habilitará algunas configuraciones que mejorarán el desempeño
(con el costo de sacrificar el tiempo de carga).

## Precompilación de Assets

En volt puedes precompilar todos los assets de tu app en un folder llamado /public. Al realizar la precompilación,
volt realiza los siguientes pasos:

1.- Precompilar todos lo archivos de opal
2.- Minificar archivos js/opal (por medio de [uglifier](https://github.com/mishoo/UglifyJS2))
3.- Minificar archivos css (via [csso](https://github.com/css/csso))
4.- Concatenar css y javascript en archivos únicos (para realizar menos requests en los clientes)
5.- Comprimir todas las imágenes y reducir metadata (usando varias herramientas como [image-optim](https://github.com/toy/image_optim))
6.- Renombrar los assets usando un fingerprint, para que los assets puedan ser cacheados por siempre.
(Cuando un archivo cambie, se generara un nuevo fingerprint)

Todos los archivos de assets se compilarán en la carpeta /public, la cual puedes servir directamente con
un servidor como [nginx](http://nginx/org/). Precompilar nos ayuda a mejorar la velocidad en el tiempo de 'boost', y
resultará en una menor cantidad de requests por parte del navegador.

Para precompilar tus assets, ejecuta el siguiente comando:

```VOLT_ENV=production bundle exec volt precompile```

### Caching de assets

La precompilación de assets copia todas las imagenes referentes a los archivos css/sass/html de los componentes
de la carpeta public. Notarás que todos los assets se renombran durante el proceso de precompilación , añadiendo
un codigo hash al final (eg: ```profile-```). Estos nos permite hacer un cache de todas las imagenes/fuentes/etc.
dentro de la carpeta public por un tiempo indefinido. Si el contenido de estos archivos cambia, se le asignará un
nuevo código hash. (Este proceso es parecido al realizado por rails, puedes ver una [explicación mas detallada en
su documentación](http://guides.rubyonrails.org/asset_pipeline.html) si necesitas mas información).

### Url de socket personalizado

Volt realiza consultas a la base, actualizaciones, llamados a tasks, etc.. por medio
de [websocket](https://en.wikipedia.org/wiki/WebSocket). Los websockets son creados creado una 'Actualización' de
la conexión http existente. Normalmente volt usará la conexión http existente para configurar conecciones de websocket.
A veces necesitamos conectarnos al websocket por medio de un dominio o puerto distinto (generalmente por que la aplicación
principal corre en un servidor proxy no compatible con websockets). Puedes configurar el url del websocket en
```config/app.rb``` de la siguiente manera:

```ruby
# ...

Volt.configure do |config|
  # ...

  config.public.websocket_url = 'websocket.mysite.com/socket'
  # ...
end
```

Volt agregará ws:// o wss:// antes del url si esto no ha sido especificado en el url original

## Proveedores de hosting

Los siguientes capítulos tratarán acerca de varias opciones cloud para el hosting de nuestras aplicaciones
