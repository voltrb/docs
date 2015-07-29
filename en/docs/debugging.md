# Debugging

## Sourcemaps

Volt (via Opal) has sourcemaps enabled by default.  In Chrome and Firefox, when you see a stack trace in the devtools, it will show the ruby filename/line numbers.  You can click on the filename to be taken to the original ruby file in the devtools.  You can set breakpoints and step through like you would with JavaScript.  An in browser irb is in the works as well.

By default in Volt 0.9.5.pre3 and greater, sourcemaps are enabled by default in Development mode.  You can disable them by doing:

```MAPS=false bundle exec volt server```

For performance reasons, opal and volt's code in not mapped.  This saves some time on page load.  You can enable mapping for all files by doing:

```MAPS=all bundle exec volt server```

### Framework Blackboxing

When using sourcemaps, you may see many extra files in stack traces and while stepping.  Framework Blackboxing lets you treat things like Volt and Opal like native code, so they will be ignored.  You can add the following blackbox check to blackbox Volt and Opal.

```
/assets/volt/volt/app\.js$|/assets/js/volt_watch\.js$|/assets/js/volt_js_polyfills\.js$
```
