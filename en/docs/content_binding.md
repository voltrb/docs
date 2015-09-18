# Content binding

The most basic binding is a content binding:

```html
<p>Hello {{ name }}</p>
```

The content binding runs the Ruby code between ```{{``` and ```}}```, then renders the return value.  Any time the data a content binding relies on changes, the binding will run again and update the text.  Text in content bindings is html escaped by default.

## Raw

You can disable html escaping by using the ```raw``` method:

```html
<p>Your html is {{ raw your_html }}.</p>
```

Using raw is considered dangerous because if the user controlled html is displayed to another user, they can easily inject any javascript (by using something like ```<img src=".." onload="somejs" />```)  This is known as a Cross Site Scripting Attack.  Only use raw if you understand how a Cross Site Scripting Attack works and how to avoid them.
