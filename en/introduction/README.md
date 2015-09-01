# Goals

Volt has the following goals:

1. Developer happiness
2. Eliminate duplication by sharing of code between the client and server
3. Automatic data syncing between client and server
4. Built apps as nested components.  Components can be shared (via gems), or run as services.
5. Concurrency.  Volt provides tools to simplify concurrency.
6. Intelligent asset management
7. Secure (shouldn't need to be said, but it does)
8. Fast, light, and scalable
9. Understandable code base

# Road Map

Many of the core Volt features are implemented.  We still have a bit to go before 1.0, most of it involving models.

1. Data Provider API - an abstraction to make it easy to create adaptors for any database/datastore.
2. Oauth Integration - the plan is to integrate omniauth to make it easy to use any omniauth provider.
3. Migrations to add database indexes from Volt
4. Server Side HTML Prerendering - the plan is to allow the server to render the html for a page first, then tie in the compiled client side ruby once the code is loaded.
