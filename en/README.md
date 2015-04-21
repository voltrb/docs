# Introduction

Volt is a Ruby web framework where your Ruby code runs on both the server and the client (via [opal](https://github.com/opal/opal)).  The DOM automatically updates as a user interacts with the page. Page state can be stored in the URL. If the user hits a URL directly, the HTML will first be rendered on the server for faster load times and easier indexing by search engines, then be maintained in the client.

Instead of syncing data between the client and the server via HTTP, Volt uses a persistent connection. When data is updated on one client, it is updated in the database and in any other listening clients (with almost no setup needed).

Page HTML is written in a template language where you can put Ruby between ```{{``` and ```}}```.  Volt uses data flow/reactive programming to automatically and intelligently propagate changes to the DOM (or any other code that wants to know when a value changes).  When something in the DOM changes, Volt intelligently updates only the nodes that need to be changed.

See some demo videos here:

- [Volt Todos Example](https://www.youtube.com/watch?v=KbFtIt7-ge8)
- [What Is Volt in 6 Minutes](https://www.youtube.com/watch?v=P27EPQ4ne7o)
- [Pagination Example](https://www.youtube.com/watch?v=1uanfzMLP9g)
- [Routes and Templates](https://www.youtube.com/watch?v=1yNMP3XR6jU)
- [Isomorphic App Development - RubyConf 2014](https://www.youtube.com/watch?v=7i6AL7Walc4)

Check out demo apps:
 - https://github.com/voltrb/todomvc
 - https://github.com/voltrb/blog5

