# View Bindings

(Previously called Template Bindings)

All ```views/*.html``` files (view files) can be rendered inside other views using the ```view``` binding.


```html
{{ view "header" }}
```

The string you pass to ```view``` should be a *view path*.  Both view bindings and tags (which we'll cover later) lookup views and controllers in the same way.

Everyone wishes that we could predict the scope and required features for each part of an application, but in the real world, things we don't expect to grow large often do and things that we think will be large don't always end up that way.  View bindings and tags let you quickly setup reusable code and views.  The location of views or tags code can be moved as they grow without changing the way they are invoked.

Lets take a look at example lookup paths for a sample view.

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

Once the file for the control or view is found, Volt will look for a matching controller.  If the view file does not have an associated controller, a new ```ModelController``` will be used.  Once a controller is found and loaded, a corresponding "action" method will be called on it if it exists.  Action methods default to the name of the view file (without .html)
