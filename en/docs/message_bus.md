# Message Bus

Volt includes a message bus interface which provides a pub/sub interface between all volt instances (server, console, runner, etc..) inside a volt cluster (any instance connected to the same database)  Volt ships with a PeerToPeer message bus, but you can create or use other message bus's.

The message bus is used internally in volt to push model updates between instances.  The updates can then be sent to any browsers connected to the volt instance.  This allows Volt to easily scale out horizontally while keeping live update push support.

## PeerToPeer Bus

The default peer to peer bus uses the database to sync a list of ip's and ports for socket servers that the instances can setup.  (See the generated ```config/app.rb``` code for configuration details)  As long as the servers can talk to each other over the network, everything should *just work*™.  (In many deployment situations, servers can talk between each other in a private cloud)  If the servers only have some ports exposed, you can specify the available ports in ```config/app.rb```

## Message Bus in App Code

The message bus can also be used from your app's code.  The message bus provides a ```subscribe``` and ```publish``` method.

**TODO: need to add more docs for using the message bus**

## Custom Message Bus

You can create your own message bus implementation by implementing the ```BaseMessageBus``` class at ```lib/volt/message_bus/base_message_bus.rb```  Then you can set the ```config.message_bus.bus_name = 'name_of_class'``` where ```name_of_class``` is the underscored version of you class name.  See ```base_message_bus.rb``` for details on implementing your own bus.
