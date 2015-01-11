# Introduction

Volt is a Ruby web framework where your Ruby code runs on both the server and the client (via [opal](https://github.com/opal/opal)).  The DOM automatically updates as a user interacts with the page. Page state can be stored in the URL. If the user hits a URL directly, the HTML will first be rendered on the server for faster load times and easier indexing by search engines, then be maintained in the client.

Instead of syncing data between the client and the server via HTTP, Volt uses a persistent connection. When data is updated on one client, it is updated in the database and in any other listening clients (with almost no setup needed).

Page HTML is written in a template language where you can put Ruby between ```{{``` and ```}}```.  Volt uses data flow/reactive programming to automatically and intelligently propagate changes to the DOM (or any other code that wants to know when a value changes).  When something in the DOM changes, Volt intelligently updates only the nodes that need to be changed.

See some demo videos here:
- [Volt Todos Example](https://www.youtube.com/watch?v=Tg-EtRnMz7o)
- [Pagination Example](https://www.youtube.com/watch?v=1uanfzMLP9g)
- [Build a Blog with Volt](https://www.youtube.com/watch?v=c478sMlhx1o)
** Note: The blog video is outdated, expect an updated version soon.

Check out demo apps:
 - https://github.com/voltrb/todos3
 - https://github.com/voltrb/contactsdemo

