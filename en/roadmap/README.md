# Roadmap

While open source projects are tricky to predict timewise, below is the roadmap of features we want to roll out in the next six months.

| Feature                            | Target Date  | Details                                |
|------------------------------------|------------- |----------------------------------------|
| sql support/reworked model layer   | October 15th | (includes eager loading)               |
| "Auto-rest" support               | September 20th | (@jfaher said its basically done      |
| query restrictions API             |September 30th|                                        |
| Time helpers                      | Nov 1st      | Basically done, depends on Opal 0.9     |
| has_many through & polymorphic queries | November 30st |                                    |
| omniauth integration into volt-user-templates | Dec 1st |                                 |

Further out we have some larger features planned that I don't have a timeline for yet.

- RubyMontion support - I would like to integrate RubyMotion so you can use Volt (and its data syncing) to build Native iOS/Android apps as part of your Volt app.  This will probably mean having a "web" folder for html views, and an "ios", and "android" folder for rubymotion code to bind between controllers and native widgets.

- Server side rendering - The goal is to have the server be able to pre-render pages, so the page could be displayed before the JS loads.  When the JS loads, it would hook into the bindings.  The server side rendering part is basically done, what we have left to do is make it tie into the bindings that were rendered on the server.  There is also a lot of edge cases we need to handle (such as components that use inline JS and do DOM manipulation).  The current plan is to have a way to mark a component as not server-side friendly, then that component's rendering would be delayed.

