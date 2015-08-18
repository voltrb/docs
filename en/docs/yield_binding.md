# Yield Binding

When using [Tags](#tags), content that is generated in the caller, can be passed into the tag definition.
In other words the tag definition can refer to content of the caller, which has the same logic as
a yield in ruby, but is slightly different. The simple example below demonstrates.

Say you had a navigation element that you wanted to reuse, a simple list item like:

```html
<li>
    <a href="/about">
      <span class="nav_element"> About </span>
    </a>
</li>
```

This can be turned into tag easily and we could pass both link and text in with the  ```attrs```
approach shown. But this would be clumsy for the span element, and can be achieved much better
with the yield binding:

```html
<:Nav>
    <li>
        <a href="{{ attrs.href }}">
            <span class="nav_element"> {{ yield }} </span>
        </a>
    </li>
```

To use this tag to create the output in the beginning of the page, you would write the following:

```html
<:nav href="/about">About</:nav>
```

In the example above, "About" will be rendered in the place of ```{{ yield }}```.
In general, any content that is inside the calling tag will be rendered in place of ```yield``.

Lastly if you just want to get the html content as a string, you can call ```yield_html``` in the controller.  This will return a string that you can ```.watch!``` on if needed and it will re-render when the content changes.
