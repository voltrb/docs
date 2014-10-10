# Control Arguments/Attributes

Like other html tags, controls can be passed attributes.  These are then converted into an object that is passed as the first argument to the initialize method on the controller.  The standard ModelController's initialize will then assign the object to the attrs property which can be accessed with ```#attrs```  This makes it easy to access attributes passed in.

```html

<:Body>

  <ul>
    {{ _todos.each do |todo| }}
      <:todo name="{{ todo._name }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>{{ attrs.name }}</li>
```

Instead of passing in individual attributes, you can also pass in a Model object with the "model" attribute and it will be set as the model for the controller.

```html
<:Body>
  <ul>
    {{ _todos.each do |todo| }}
      <:todo model="{{ todo }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>
    {{ _name }} -
    {{ if _complete }}
      Complete
    {{ end }}
  </li>
```
