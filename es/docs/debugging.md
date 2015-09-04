# Debugging

## Sourcemaps

Volt (por medio de Opal) tiene sourcemaps habilitado por default. en Chrome y en Firefox, cuando tienes un stack trace en devtool, este nos mostrará el nombre/linea del archivo en ruby. Puedes hacer click en el nombre del archivo para ingresar al archivo Ruby original directamente en devtools. Puedes crear tus propios breakpoints como lo harías normalmente en JavaScript. También se está tratando de integrar irb en el navegador.

Por default, a partir de la versión 0.9.5.pre3 de Volt, sourcemaps esta activado automáticamente en el ambiente de desarrollo. Puedes deshabilitarlo  mediante el siguiente comando:

```MAPS=false bundle exec volt server```

Por razones de rendimiento, el código de Opal y Volt no es mapeado. Esto nos ahorra algo de tiempo en la carga de páginas. Puedes habilitar mapping para todos los archivos mediante el siguiente comando:

```MAPS=all bundle exec volt server```

### Framework Blackboxing

Cuando usas sourcemaps, generalmente verás muchos archivos extras en tu stack trace mientras hagas debugging. Framework Blackboxing te permitará tratar el código de Volt y Opal como código nativo, por lo que será ignorado. Puedes añadir el siguiente check para tener blackbox en Volt y Opal.

```
/assets/volt/volt/app\.js$|/assets/js/volt_watch\.js$|/assets/js/volt_js_polyfills\.js$
```
