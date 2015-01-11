# Each binding

For iteration over objects, you can use ```.each```

```html
{{ _items.each do |item| }}
  <p>{{ item }}</p>
{{ end }}
```

Above, if ```_items``` is an array, the block will be rendered for each item in the array, setting ```item``` to the value of the array element.

You can also call .each_with_index to place the index in a local variable within the block

```html
{{ _items.each_with_index do |item, index| }}
  <p>{{ index }}. {{ item }}</p>
{{ end }}
```

For the array: ```['one', 'two', 'three']``` this would print:

    0. one
    1. two
    2. three

You can do ```{{ index + 1 }}``` to correct the zero offset.

When items are removed or added to the array, the ```each``` binding automatically and intelligently adds or removes the items from/to the DOM.
