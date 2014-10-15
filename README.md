# Introduction

Volt is a Ruby web framework where your ruby code runs on both the server and the client (via [opal](https://github.com/opal/opal)).  The DOM automatically updates as the user interacts with the page. Page state can be stored in the URL. If the user hits a URL directly, the HTML will first be rendered on the server for faster load times and easier indexing by search engines.

Instead of syncing data between the client and server via HTTP, Volt uses a persistent connection between the client and server. When data is updated on one client, it is updated in the database and any other listening clients (with almost no setup code needed).

Pages HTML is written in a template language where you can put ruby between ```{{``` and ```}}```.  Volt uses data flow/reactive programming to automatically and intelligently propagate changes to the DOM (or any other code wanting to know when a value updates).  When something in the DOM changes, Volt intelligently updates only the nodes that need to be changed.

See some demo videos here:
- [Volt Todos Example](https://www.youtube.com/watch?v=Tg-EtRnMz7o)
- [Build a Blog with Volt](https://www.youtube.com/watch?v=c478sMlhx1o)
** Note: The blog video is outdated, expect an updated version soon.

Check out demo apps:
 - https://github.com/voltrb/todos3
 - https://github.com/voltrb/contactsdemo
