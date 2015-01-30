# Controller Actions

When a template binding or tag renders a view, it first loads a controller.  There are four callbacks around the rendering.  The ```{action}``` is the same as the view file's name.  So if you were rendering ```about.html```, ```about``` would be the action.  Simply create the correct method in the controller and it will called at the time.

| action name           | description |
|-----------------------|-----------------------------------------------------|
| ```{action}``` | called before anything renders.  Setup data you need       |
| ```{action}_ready``` | called after the view renders.  Run any code where you need to bind directly to the dom.  jQuery setup code for example (bootstrap components) |
| ```before_{action}_remove``` | called before the view is removed (unrendered).  Cleanup any dom bindings here. |
| ```after_{action}_remove``` | called after the view is removed from the dom.  Cleanup anything in the controller that needs to be cleaned up. |

Most of the time all you will need is the action method to setup the controller, model, etc...

