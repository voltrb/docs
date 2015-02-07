# Yield Binding

When using [Tags](http://docs.voltframework.com/en/docs/controls.html), content can be passed between tags as follows:

```html
<:nav href="/about">About</:nav>
```

In the example above, "About" can be rendered elsewhere using ```{{ yield }}```.  Here's an example using a tag to render a section.

```html
<:Nav>
    <li>
        <a href="{{ attrs.href }}">{{ yield }}</a>
    </li>
```

Any content or other bindings can be passed into the ```tag```.  You can also pass content to component tags and yield inside of their views.

Lastly if you just want to get the html content as a string, you can call ```yield_html``` in the controller.  This will return a string that you can ```.watch!``` on if needed and it will re-render when the content changes.
