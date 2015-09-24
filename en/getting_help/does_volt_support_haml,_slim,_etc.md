# Does Volt support Haml, Slim, etc...

**Update** - Yes, volt supports slim, thanks to @ASnow: https://github.com/asnow/volt-slim

We don't have HAML support yet.  Below is a brief explination of what is involved and what it takes.

This is a common question for those coming from Rails because in Rails is easy to add support for more template languages.  In Rails a template render takes in a path to a template and an object to be used as the context.  Then the result generated is **a string**.

In volt however, templates are first rendered to a compiled template that can be sent to the client side.  Templates aren't _rendered to a string_, they are _built to a target_.  Volt currently supports two targets:

- the actual dom
- a string (for rendering parts of templates in tag attributes, or e-mail's, or server side html)

When rendering to the actual dom, Volt tracks the locations of the rendered DOM nodes, so when any data used to render those nodes changes, the DOM can be updated without re-rendering the whole DOM.  This makes for fast efficient DOM updates with a minimum number of DOM operations and no need for any diffing like in other frameworks.  Volt's bindings know how to update with the least number of DOM updates.

## So what does it take to render Haml, etc...

Its not too bad, but out of the box gems like haml and slim aren't designed for what Volt needs. Any template language that can compile to Volt's compiled template format can be used.  The compiled template format is ruby code (that gets compiled to the client via Opal).  It consists of html and bindings.  The html has placeholders (currently special html comments) that show where the binding should be rendered.  The bindings are ruby Procs that setup instance of the bindings.  (Volt::EachBinding, Volt::ContentBinding, Volt::AttributeBinding, Volt::IfBinding, and Volt::EventBinding)

To make haml or slim compile, someone will need to modify slim or haml to produce the Volt compiled template format (instead of pre-rendered html)  It shouldn't be that hard, but its not trivial.  If you are interested, hit up @ryanstout on our [gitter](https://gitter.im/voltrb/volt).
