# View Bindings

All ```views/*.html``` files (view files) can be rendered inside other views using the ```view``` binding.  The view binding takes in a *path string* and renders a view based on that path.  The contents of the view file replace where the view binding is in the original view file.


```html
<h1>Header stuff</h1>

{{ view "header" }}
```

If the header view file looked like this:

```html
<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
</ul>
```

When the original file is rendered it will look like:

```html
<h1>Header stuff</h1>

<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
</ul>
```
(Notice that the view binding was replaced with the contents of the "header" file)

The string you pass to ```view``` should be a *path string*.  Both view bindings and tags (which we'll cover later) lookup views and controllers in the same way.

Everyone wishes that they could predict the scope and required features for each part of an application. In the real world, however, things we don't expect to grow large often do, and things we think will be large don't always end up that way.  View bindings and tags let you render controllers and views without worrying if the code is in the same view folder, a component, or in a gem.  The location of views or tags code can be moved as they grow without changing the way they are invoked.

Lets take a look at some example lookup paths for a sample view.

```html
{{ view "header" }}
```

Given the string "header", Volt will search for the view file in the following locations (in order):

| Section   | View File    | View Folder    | Component   |
|-----------|--------------|----------------|-------------|
| header    |              |                |             |
| :body     | header.html  |                |             |
| :body     | index.html   | header         |             |
| :body     | index.html   | index          | header      |
| :body     | index.html   | index          | {gems}/header |

Once a view is found, the associated controller will be loaded first.  The controller for a view file is always {something}_controller.rb where {something} is the name of the folder the view is in.  (Note, views should always be at {component}/views/{something}.html - Volt does not support folders within the views folder)

Volt checks the following in order for a matching view:

1. **Section** - view files (eg. something.html) are composed of sections.  Sections start with a ```<:SectionName>``` and are not closed.  Volt will look first for a section in the same view, and use the html in the section if one matches.

2. **Views** - next, Volt will look for a view file with the same *views* folder as the current view file.  If found, it will render the **Body** section of that view.

3. **View folder** - failing above, Volt will look for a view folder with the component with a matching name, and an index.html file within that folder.  It will render the :Body section of that view.  If a controller exists for the view folder.

4. **Component** - next, all folders under app/ are checked.  The view path looked for is ```{component}/index/index.html``` with a section of :body.

5. **Gems** - lastly, the app folder for each gem that starts with ```volt-``` is checked.  They are checked for similar paths to component, above.

Keep in mind each time a view is rendered, a new controller instance is created to be the context for that view.

When you create a view binding, you can also specify multiple parts of the search path in the name.  The parts should be separated by a ```/```.  For example:

```html
    {{ view "blog/comments" }}
```

The above would search the following:

| Section   | View File    | View Folder    | Component   |
|-----------|--------------|----------------|-------------|
| :comments | blog.html    |                |             |
| :body     | comments.html| blog           |             |
| :body     | index.html   | comments       | blog        |
| :body     | index.html   | comments       | gems/blog   |

Once the file (or section) for the view is found, Volt will look for a matching controller.  If the view file does not have an associated controller, a new ```ModelController``` will be used.  Once a controller is found and loaded, a corresponding "action" method will be called on it if it exists.  Action methods default to the name of the view file (without .html) - see [Callbacks and Actions](callbacks_and_actions.md) for more info.

## Options

### Controller Group

The `:controller_group` option for views makes it possible for multiple view bindings to share the same controller instance. Normally, each individual view binding (i.e. each instance of `view` or a tag on the page) is created with its own controller instance. When two or more view bindings are passed the same string in the `controller_group` option, however, those bindings will all share the same controller object between them.

There is an example of this in the `main.html` file of new Volt apps. Both the body and the title view bindings are passed `controller_group: 'main'`, and as such they will share the same controller instance.
