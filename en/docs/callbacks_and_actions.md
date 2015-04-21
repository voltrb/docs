# Controller Actions

When a template binding or tag renders a view, it first loads a controller.  There are four callbacks around the rendering.  The ```{action}``` is the same as the view file's name.  So if you were rendering ```about.html```, ```about``` would be the action.  Simply create the correct method in the controller and it will called at the time.

| action name           | description |
|-----------------------|-----------------------------------------------------|
| before_action callbacks | All before actions are called before the main action method.  If ```stop_chain``` is called, ```{action}``` will not be called and execution will be halted. |
| ```{action}``` | called before anything renders.  Setup data you need       |
| after_action callbacks | after_action's can not call ```stop_chain``` (in an after callback, it will raise an exception) |
| ```{action}_ready``` | called after the view renders.  Run any code where you need to bind directly to the dom.  jQuery setup code for example (bootstrap components) |
| ```before_{action}_remove``` | called before the view is removed (unrendered).  Cleanup any dom bindings here. |
| ```after_{action}_remove``` | called after the view is removed from the dom.  Cleanup anything in the controller that needs to be cleaned up. |

Most of the time all you will need is the action method to setup the controller, model, etc...

