# Tutorial

Este tutorial te guiará en la creación una aplicación web básica en Volt. Esta guía asume un conocimiento básico del lenguaje Ruby y de desarrollo web. Este tutorial todavía es un trabajo en progreso :)

# Configuracion

Primero, instalemos Volt y creemos una aplicación vacía. Asegurate de que tener una versión de ruby mayor a 2.1.0 y de que rubygems este instalado

Luego instala la gema de volt:

    gem install volt

Con la gema que acabamos de instalar podemos crear un nuevo proyecto:

    volt new sample_project

Esto creará una aplicación básica dentro de la carpeta sample_project. Podemos hacer ```cd``` dentro de la carpeta y correr el servidor:

    bundle exec volt server

Por último, podemos acceder a la consola de Volt por medio del siguiente comando:

    bundle exec volt console
