# If binding

An if binding lets you provide basic flow control.

```html
{{ if _some_check? }}
  <p>render this</p>
{{ end }}
```

Blocks are closed with a ```{{ end }}```

When the if binding is rendered, it will run the ruby code after if.  If the code is true it will render the code below.  Again, any changes to the branch check code will update the showing branch.

If bindings can also have ```elsif``` and ```else``` blocks.

```html
{{ if _condition_1? }}
  <p>condition 1 true</p>
{{ elsif _condition_2? }}
  <p>condition 2 true</p>
{{ else }}
  <p>neither true</p>
{{ end }}
```
