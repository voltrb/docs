# Content binding

The most basic binding is a content binding:

```html
<p>Hello {{ name }}</p>
```

The content binding runs the Ruby code between {{ and }}, then renders the return value.  Any time the data a content binding relies on changes, the binding will run again and update the text.  Text in content bindings is html escaped by default.
