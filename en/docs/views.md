# Views

Views are files with an .html extension that can include ruby code to control how they are rendered.  Volt compiles the views on the server before sending them to the client.  Views might look something like this:

```html
<!-- app/main/views/main/index.html -->
<:Title>
My Page

<:Body>
<h1>My Page</h1>

<p>Welcome {{ Volt.current_user.name }}!</p>
```

# Sections

Volt views have their own simple templating language.  They can be broken up into sections. Sections start with a section header.  A section header looks like the following:

```html
<:Body>
```

Section headers should start with a capital letter so as not to be confused with [tags](#tags).  Section headers do not use closing tags.  If no section header is provided, the ```:Body``` section is assumed.

Sections help you split up different parts of the same content (title and body usually), but within the same file.

# Bindings

In Volt, views are written in a simple template language where ruby can be inserted anywhere between ```{{``` and ```}}```.  Volt lets you use the usual flow control statements in views (```if```, ```elsif```, ```else```, and ```each```).  You can also render other views using the ```view``` binding.

# Controller Backing

While Volt is more of a Model View ViewModel (MVVM) framework than an MVC framework, we have opted to use the controller terminology - this just means we use the term 'Controller' instead of 'ViewModel'.

Any method call or instance variable lookup in a view runs in the context of such a controller.

If you have a view at ```app/main/views/index/index.html``` it will load the controller at ```app/main/controller/index_controller.rb```.
