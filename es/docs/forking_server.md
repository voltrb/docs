# Forking Server

En modo development, volt necesita saber cuando el código cambio dentro de la aplicación. Para
detectar estos cambios, volt usa la gema ```listen``` la cual usa el api del sistema operativo para
detectar cambios. En development, usando MRI en OSX o Linux. Volt arrancará la aplicación por
medio de ForkingServer. ForkingServer corre detras de rack , por lo que se puede
usar cualquier webserver compatible (thin, puma, etc...)

## Como funciona

La idea detras del servidor forking es cargar la mayor parte de dependencias de nuestra aplicación (ruby,
volt, cualquier gema) y luego crear un proceso 'hijo' separado del proceso principal. En el proceso hijo se
cargara el código de tu aplicación. Cuando el proceso padre reciba un request, este lo pasa al
proceso hijo (por ahora usando DRb). El proceso hijo responde al request y retorna el resultado al
servidor padre, el cual retorna el resultado al browser.

Cuando el código cambia, el cambio se detectará por medio del proceso padre. Si el cambio requiere un reload,
el proceso padre creará otra vez un nuevo proceso hijo, el cual cargará el código de la aplicación nuevamente.

## Por que es rápido

Ya que la cantidad de código es pequeña en comparación con el código de ruby, de volt y de todas sus dependencias, la
app se puede volver a cargar de manera muy rápida (cuando se han hecho nuevos cambios). Las partes mas pesadas ya han sido previamente
cargadas. Linux y OSX soportan un forking de "copy on write". Esto significa que cuando se crea un nuevo proceso, en lugar
de copiar todo el proceso original de memoria, el proceso no se copiará hasta que cada uno de los bloques en memoria haya
sido cambiado. Como el mayor parte del código en memoria de la aplicación nunca cambia, el proceso de forking se vuelve
muy rápido.

## Ventajas

Una de las ventajas de la carga de código por medio de forking es que no necesitamos de ningun tipo de estrategia especial ni código
específico para cada caso especial. En rails, por ejemplo, se hace el 'unload' de las clases haciendo 'undefine' de la constante, y
luego haciendo otra vez 'require' al archivo. Para que esto funcione el archivo debe tener un nombre especificó. El problema
principal con esto son los efectos secundarios. Usando la estrategia del servidor de forking, tu aplicacion volverá a arrancar como
cuando la arrancaste por primera vez (pero una fracción mas pequeña de tiempo)

## Otras Plataformas

La principal limitación de ForkingServer es que no cuenta con soporte para Windows o Jruby por que ninguno de los dos soporta
'fork'. Planeamos agregar una alternativa para las estrategias de reloading tanto en windows como en Jruby.
