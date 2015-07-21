# Url

In volt you can access information about the url via the ```url``` method, which is available in controllers.  The url has the following methods, which currently are getters only (setters coming soon.)

- scheme
- host
- port
- path
- query
- fragment

Each method will reactively update when the url changes.

Modified at {{ file.mtime }}
