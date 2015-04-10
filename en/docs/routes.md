# Routes

Routes in Volt are very different from traditional backend frameworks.  Since data is synchronized to the client using websockets, routes are used for two different reasons in Volt.  Volt provides two different types of routes in the same file: ```client``` routes and http routes (```get```, ```post```, ```put```, and ```delete```)

## Client Routes

To serialize the state of the application into the url in a pretty way.  When a page is first loaded, the URL is parsed with the routes, and the params model's values are extracted and set from the URL.  Later, if the params model is updated, the URL is updated based on the routes.

This means that routes in Volt have to be able to go both from URL to params and params to URL.  It should also be noted that if a link is clicked and the controller/view to render the new URL is within the current component (or an included component), the page will not be reloaded, the URL will be updated via the HTML5 history API, and the params hash will update to reflect the new URL.  You can use these changes in params to render different views based on the URL.

## Http Routes

To provide data to clients that need to access it via Http (a REST api for example)
