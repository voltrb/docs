# If binding

An ```if``` binding lets you provide basic flow control.

```html
{{ if some_check? }}
  <p>render this</p>
{{ end }}
```

Blocks are closed with ```{{ end }}```

When the ```if``` binding is rendered, it will run the ruby code after "if".  If the code is true, it will render the code in the block below.  Any changes to the data in the ```if``` condition will update the rendered block.

If bindings can also have ```elsif``` and ```else``` blocks.

```html
{{ if condition_1? }}
  <p>condition 1 true</p>
{{ elsif condition_2? }}
  <p>condition 2 true</p>
{{ else }}
  <p>neither true</p>
{{ end }}
```

## Unless

Unless is supported as well.

```html
{{ unless some_check? }}
  <p>render this when some_check? is false</p>
{{ end }}
```
