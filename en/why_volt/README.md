# Why Volt

I've been building websites since 1996.  My first real web application was in 1998.  In the time since, I've seen layer after layer of tools and technologies added to web development stacks.  Each layer enables more power and flexability, but it also add complexity.  Even for most simple apps, a modern web developer needs to be familiar with html, css, javascript, a back-end language, http, headers, caching, a back-end framework, a front-end framework, REST, asset compilation, and more.

The list of tools and technologies can go on and on.  To make building web applications faster we need to be able to outsource some of the complexity.  We do this in other spaces, but in some ways we have yet to in the web community.  For example, in most languages we no longer manage our own memory, we don't (usually) write our own file systems, and we don't typically render our UI directly.  Instead we use things like garbage collection and UI toolkits to hide that complexity.

Having an understanding of how garbage collection works is useful and can make you a better programmer, but littering your code with (possibly buggy) mallocs and free's only adds to the complexity.

Volt tries to do reduce web complexity in a similar way.  Lets look at how it simplifies some of the normal complexity.

### Language

Until recently all web applications were written in a backend language that wasn't JavaScript and JavaScript as a front-end language.  Then people started using JavaScript as a back-end language.  The node community validly argued that using one language on client and server simplifies things.  The Volt team completely agrees, however we feel the future is compiling to JavaScript and not JavaScript as a server language.

Running the same language on client and server does reduce some cognative load by preventing context switches, however the big win is being able to run *the same code* on both sides.  Something most node programmers are not doing yet.

### Front-end and Back-end framework

Today web apps are typically built with a back-end framework and a front-end framework.  This means two different ways of doing similar things.  Volt is one framework that runs on both the client and the server.

### HTTP and REST

Since most apps are built with different tools on the client and server, data is synced via REST api's.  Volt lets you use access data using Model classes that are automatically synced between the client and server with no code from a you as a developer.

### Full Stack Components

The achelies heel of most web stacks is the lack of a standard between the client and server.

