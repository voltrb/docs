# Assets

**Note, asset management is still early, and likely will change a bit**

## CSS and JavaScript

In Volt, assets such as JavaScript and CSS (or sass) are automatically included on the page for you.  Anything placed inside of a components asset/js or assets/css folder is served at /assets/{js,css} (via [Sprockets](https://github.com/sstephenson/sprockets)).  Link and script tags are automatically added for each css and js file in assets/css and assets/js respectively.  Files are included in their lexical order, so you can add numbers in front if you need to change the load order.

Any JS/CSS from an included component or component gem will be included as well.  By default [bootstrap](http://getbootstrap.com/) is provided by the volt-bootstrap gem.

## Images, Fonts, Other Assets

It is reccomended that images and other assets be put in ```app/{component}/assets/images``` (or fonts, etc..)  Then the url for an image for example would be: ```/assets/{component}/assets/images/...```

**Note: asset bundling is on the TODO list**
