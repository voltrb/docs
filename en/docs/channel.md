# Channel

Controllers provide a `#channel` method, that you can use to get the status of the connection to the backend.  Channel's access methods are reactive and when the status changes, the watching computations will be re-triggered.  It provides the following:

| method      | description                                               |
|-------------|-----------------------------------------------------------|
| connected?  | true if it is connected to the backend                    |
| status      | possible values: :opening, :open, :closed, :reconnecting  |
| error       | the error message for the last failed connection          |
| retry_count | the number of reconnection attempts that have been made without a successful connection |
| reconnect_interval | the time until the next reconnection attempt (in seconds) |

More can be found in the [source code](https://github.com/voltrb/volt/blob/master/lib/volt/page/channel.rb).
