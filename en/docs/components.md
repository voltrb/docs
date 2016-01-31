# Components

Apps are made up of Components.  Each folder under ```app/``` is a component.  Components can also be included from gems.  Apps are commonly broken up into multiple components.  Components can be anything from a small reusable widget to a large section of the app.  Since components can be included in other components, we recommend starting with smaller components and building up larger ones.  Components that are likely to be reused can be built as [component gems](component_gems.md), or you can move a component into a gem at a later time.

The code inside of a component can be accessed in a few ways.  Model code is accessible from anywhere in the app.  Views/controllers can be accessed using tags or view bindings.  See [tags](tags.md) for info on how view path lookup works.

The overall idea of components is to keep more parts of your code isolated so they can be independently tested and abstracted.

Some example components might be:

__Widgets__
- A field with validations
- A slider
- WYSIWYG editor
- file uploader
- Google map

__Pages__
- login page
- user signup/login/forgot password
-

__Parts of app__
- blog
- cms
- admin area

A good rule of thumb is to use more components than you think you'll need, since there is little overhead in splitting parts of your app.

## Generate a Component

You can add a new component to an app with:

```bundle exec volt generate component NAME```

## Components and Routing

When you visit a route, it loads all of the files in the component on the front end, so new pages within the component can be rendered without a new http request.  If a URL is visited that routes to a different component, the request will be loaded as a normal page load and all of that component's files will be loaded.  You can think of components as the "reload boundary" between sections of your app.  [Note: currently only the "main" component is supported for initial page load, expect "reload boundry" support soon]
