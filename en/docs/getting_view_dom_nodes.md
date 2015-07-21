# Getting view DOM nodes

While you can build many things with just Volt's bindings.  Often you may want to directly change the DOM in a view.  There are two parts to working directly with the DOM.

- When to start
- Getting the container

## When to start

Because Volt renders pages for you on the client, you can not use something like ```$(document).ready``` in jQuery.  (Note: Volt ships with jQuery if you want to use it)  Instead, we need to use an {action}_ready method.  (See [Callbacks and Actions](callbacks_and_actions.md) for more info)  You may need to (and should) break up your views to use multiple controller/views in order to get triggers for each part of a larger view.

## Getting the DOM node

Unlike some other frameworks, views in Volt can have multiple nodes at the root.

```html
<:Item>
    <td>{{ label }}</td>
    <td><a href="/edit/{{ id }}">Edit</a></td>
```

### Dom Range for View

In the case below, we can't simply ask for the "node" of the view.  Instead Volt uses [Dom Range's](https://developer.mozilla.org/en-US/docs/Web/API/Range) to represent the nodes inside of the view.  You can get back a range for the nodes in the view by calling: ```dom_nodes``` on the controller.

### Container Node

Working with DOM ranges can be difficult however, since most libraries (jquery for example) are used to working with nodes.  To get the closest node that contains all of the view you can call ```container``` in the controller.  (Keep reading though for a more useful method)

### First Element

In the example above with two td's however, this will return the table, which is the only common node in an example with more than one "root" nodes in the view.  If you have a single node as the root in a view like below:

```html
<:Post>
    <section>
        <h1>{{ title }}</h1>
        <p>{{ body }}</p>
    </section>
```

In the above example, the section tag is a single root node for the whole view.  However due to the whitespace, there are technically other nodes, so ```container``` will return the node above the section.  If you know you only have one node in a view, you can use ```first_element``` to get the first element node in a view.  (An element node is a tag)



Modified at {{ file.mtime }}
