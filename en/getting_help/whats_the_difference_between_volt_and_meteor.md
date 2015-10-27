# What's the difference between Volt and Meteor?

Volt and Meteor are similar in a lot of ways, mainly because they are trying to solve similar problems.  Besides Volt using Ruby and Meteor using JavaScript, there are some other core differences:

## Components

One of the big differences is the way volt apps are built as components. I believe this makes for easier code reuse (as gems), and enforces more modularity. It also means you can set "page load boundaries", so you can build your app as multiple "single page apps". This means you don't need to load up everything in the entire app client side code on the first page load. You can have parts where the browser does a normal get request to load up other sections.

## Client Side Database Access

In meteor you work with the database directly (insert, create, etc..), in volt you work with objects. You create classes that inherit from Volt::Model, and based on how the objects are setup, they will be persisted in different places. Since the objects are not tied to the persistance (think repository pattern), you can test them in isolation. It also provides a place to put business logic related to the object and prevents that logic (usually validations/permissions) from being violated.

## Data Handling

Another big difference is the way we handle data. Meteor has you say what data the client will need when the page loads by using publish. You then subscribe to that data on the client. While you can pass options to publish via subscribe, it is a little tricky imho. The main reason for doing this is so they can work with the data on the client without needing to wait for a callback. The problem with this is there are lots of cases where you need to wait for a server round trip. A good example is a unique validation, this needs to hit the server to check it. In Volt, we load data based on what is being reactively watched. Then things like save return a promise you can use if you need to wait for the results. We have plans to add extensions to Opal similar to iced coffeescript to give us async/await style syntax to make the promise api transparent and synchronous. (still in the works). The thing I see in a lot of meteor apps is they stop using mini-mongo on the client after a while and start using meteor methods for everything. I think this shows that there are some difficult challenges with the way mongo handles data. The other thing I see is that way too much data is sent to the client because its hard to know at load time what data you'll need. While I'm not saying Volt's way is perfect, I believe it solves a few of the problems meteor's way doesn't.

## Other things

This is just a quick over-view of the differences.  Just a few more small differences:

- Volt uses convention and file structure more than Meteor.
- Volt's router is entirely different.
- Volt hasn't raises $31MM in venture capital :-)

There are a lot more differences, but those are the ones that come to mind right now.
