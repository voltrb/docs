# Assets

## CSS and JavaScript

In Volt, assets such as JavaScript and CSS (or sass) are, by default, automatically included on the page for you.  Anything placed inside of a components asset/js or assets/css folder is served at /assets/{js,css} (via [Sprockets](https://github.com/sstephenson/sprockets)).  Link and script tags are automatically added for each css and js file in assets/css and assets/js respectively.  Files are included in their lexical order, so you can add numbers in front if you need to change the load order.

Any JS/CSS from an included component or component gem will be included as well.  By default [bootstrap](http://getbootstrap.com/) is provided by the volt-bootstrap gem.

### Disabling auto-importing of assets
If you would like to manually specify the CSS and JS assets to be loaded, you can disable auto-importing of CSS and JS on a component-by-component basis by specifying ```disable_auto_import``` at the top of your component's ```config/dependencies.rb```. You can then include CSS and JS files for that component manually using the helpers below.

```disable_auto_import``` only disables automatic including of JS and CSS files - fonts, images, and other assets are not affected.

For example, if your component's ```config/dependencies.rb``` file looks like this:

```
disable_auto_import
css_file 'manifest.scss'
# font awesome
css_file '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'
javascript_file 'my_js.min.js'
```
Only the 'manifest.scss', a link to the CDN copy of FontAwesome, and the JS file 'my_js.min.js' would be included on the page.

##### javascript_file
```javascript_file 'my_js.js'```
This helper will look for your file under ```app/{component}/assets/js```.

##### css_file
```css_file 'my_scss.scss'```
This helper will look for your file under ```app/{component}/assets/css```. You can use it with SCSS or CSS files. Using this, you can write a manifest file that specifies the load order for your CSS/SCSS.

## Images, Fonts, Other Assets

It is recommended that images and other assets be put in ```app/{component}/assets/images``` (or fonts, etc..)  Then the url for an image for example would be: ```/assets/{component}/assets/images/...```. Images and other assets are not affected by ```disable_auto_import```.

**Note: asset bundling is on the TODO list**
