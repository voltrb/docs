# Volt Deployment

## Running in Production

When you deploy your app, it is reccomended that you run volt with the VOLT_ENV=production environment variable set.  This will disable code reloading and sourcemaps and enable some performance boosting settings (at the cost of load time).

## Asset Precompilation

In volt, you can precompile all of your apps assets to a /public folder.  When precompiling, Volt does the following:

1. precompiles all opal files
2. minifies JS/opal js (via [uglifier](https://github.com/mishoo/UglifyJS2))
3. minified CSS (via [csso](https://github.com/css/csso))
4. concat css and javascript into single files (to make less requests on the clients)
5. lossly compresses all images and strip metadata (using various tools with [image-optim](https://github.com/toy/image_optim))
6. rename assets using fingerprinting, so the assets can be cached forever.  (Because if the file changes, a new fingerprint will be generated and linked to)

All assets will be compiled into the /public folder, which you can serve directly via something like [nginx](http://nginx.org/).  Precompiling results in a substantial initial page load speed boost, and results in less requests from the browser.

To precompile your app's assets, simply run:

```VOLT_ENV=production bundle exec volt precompile```

### Asset Caching

Asset precompiling copies images referenced in css/sass/html files from components into the public folder.  You may notice that all assets are renamed during precompiling to have a fingerprint hash on the end (eg: ```profile-```)  This lets you cache all images/fonts/etc. in the public folder for an indefinite amount of time.  If the contents of the file changes, a new hash will be assigned.  (This is the same process used by rails, see their [much more complete docs](http://guides.rubyonrails.org/asset_pipeline.html) for more info)

See the [Assets](docs/assets.md) section for details on setting up image tags, css, etc. to point to assets correctly.

## Hosting Providers

The rest of this chapter highlights various deployment options for Volt on popular cloud providers.
