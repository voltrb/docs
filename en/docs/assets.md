# Assets

## CSS and JavaScript

In Volt, assets such as JavaScript and CSS (or sass) are, by default, automatically included on the page for you.  Anything placed inside of a components assets/js or assets/css folder is served at /assets/{js,css} (via [Sprockets](https://github.com/sstephenson/sprockets)).  Link and script tags are automatically added for each css and js file in assets/css and assets/js respectively.  Files are included in their lexical order, so you can add numbers in front if you need to change the load order.

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

It is recommended that images and other assets be put in ```app/{component}/assets/images``` (or fonts, etc..)  When an app is deployed to production, you can precompile your assets, and Volt will append a fingerprint of the file contents (a file hash) onto the end of the filename.  This lets you cache all assets indefinitely.  (See [Deployment](deployment/README.md) for more details)

The app folder in volt is mounted at the /app url.  So an asset at:

```app/main/assets/images/profile.jpg``` can be accessed at ```/app/main/assets/images/profile.jpg```  Typically though, you will use the asset_path helper(s) to reference assets.  These helpers can later rewrite urls when precompiling, to allow for various precompile optimizations.

To make the asset path rewriting work, you need to change the way you reference asset paths in css and html.

In css/sass, you can simply change:

```background-image: url(../images/something.png);``` to ```background-image: asset-url("../images/something.png");```

^ be sure to include the quotes.

In html, instead of referencing an image src directly, you should do the following:

```html
<img src="{{ asset_url('../../assets/images/something.png') }}" />
```

^ note, when using asset_url, the path becomes relative to the .html file, not where it will be rendered.  You can also use the following url scheme:

```css
background-image: url(blog/assets/images/header.jpg);
```

In the example above, we start with in the app folder.  This lets you use assets from other components.
