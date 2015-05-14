# What browsers does Volt support?

Since Firefox and Chrome have been auto-updating for a while, your probably wondering about IE.  The good news is Opal supports IE way back (the rumor is IE6, because one of the core dev's needs support for it).  While Volt only targets IE10 at the moment, we're working on a volt-ie8to9 gem that will add back support for IE 8-9.  The only thing missing at the moment is a fallback for websockets.

## Limited Features

There are a few features of Volt that only work on certain browsers.

1) Binding on hidden fields.
To bind on hidden fields, the browser needs mutation observer events.  These are only supported in >=IE11.  There is a polyfill that can be used to support IE8-10, which we will be bundling into a gem.  Check back here soon.
