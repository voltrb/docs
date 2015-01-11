# Template Bindings

All ```views/*.html``` files are templates that can be rendered inside of other views using the template binding.

```html
{{ template "header" }}
```

The string passed to ```template``` should be a *template path*.  Both templates and tags (which we'll cover later) lookup views and controllers in the same way.

Everyone wishes that we could predict the scope and required features for each part of an application, but in the real world, things we don't expect to grow large often do and things that we think will be large don't always end up that way.  Templates and tags let you quickly setup reusable code/views.  The location of templates or tags code can be moved as they grow without changing the way they are invoked.

Lets take a look at example lookup paths for a sample template.

```html
{{ template "header" }}
```

Given the string "header", Volt will search for the view file in the following locations (in order):

| Section   | View File    | View Folder    | Component   |
|-----------|--------------|----------------|-------------|
| header    |              |                |             |
| :body     | header.html  |                |             |
| :body     | index.html   | header         |             |
| :body     | index.html   | index          | header      |
| :body     | index.html   | index          | gems/header |

Once a view is found, the associated controller will be loaded first.

Each part is explained below:

1. section
Views are composed of sections.  Sections start with a ```<:SectionName>``` and are not closed.  Volt will look first for a section in the same view.

2. views
Next, Volt will look for a view file with the template path.  If found, it will render the body section of that view.

3. view folder
Failing above, Volt will look for a view folder with the control name, and an index.html file within that folder.  It will render the :body section of that view.  If a controller exists for the view folder, it will make a new instance of that controller and render in that instance.

4. component
Next, all folders under app/ are checked.  The view path looked for is ```{component}/index/index.html``` with a section of :body.

5. gems
Lastly, the app folder of all gems that start with ```volt``` are checked.  They are checked for similar paths to component, above.


When you create a template binding, you can also specify multiple parts of the search path in the name.  The parts should be separated by a ```/```.  For example:

```html
    {{ template "blog/comments" }}
```

The above would search the following:

| Section   | View File    | View Folder    | Component   |
|-----------|--------------|----------------|-------------|
| :comments | blog.html    |                |             |
| :body     | comments.html| blog           |             |
| :body     | index.html   | comments       | blog        |
| :body     | index.html   | comments       | gems/blog   |

Once the view file for the control or template is found, Volt will look for a matching controller.  If the template file does not have an associated controller, a new ```ModelController``` will be used.  Once a controller is found and loaded, a corresponding "action" method will be called on it if it exists.  Action methods default to "index" unless the component or template path has two parts, in which case the last part is the action.
