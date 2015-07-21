# Model States

Because models run on the client and there is latency between the client and the server, Volt provides a few "state" methods to see if a model is synced to the server.  If you save from a buffer, the Promise returned from .save! will only resolve once the data has been saved on the server, so these state methods are mostly for showing the user what is happening.

## Saved State

On any store model (or buffer) you can call .saved_state and will get back one of the following:

| State     | Description                                                           |
|-----------|-----------------------------------------------------------------------|
| not_saved | The model has not been saved to the server                            |
| saving    | The model data is in the process of being saved                       |
| saved     | The model is saved to the server and the current data is up to date   |

## Loaded State

| State     | Description                                                           |
|-----------|-----------------------------------------------------------------------|
| not_loaded| The ArrayModel is not loaded, and nothing is depending on the model to make it load (this is an internal volt state you won't see) |
| loading   | The ArrayModel is loading its data                     |
| loaded    | The data is loaded and being synced with the server    |
| dirty     | The data was loaded at one point, but is no longer being synced with the server.  This will happen if no bindings are reactively listening on the data or anything produced from the data |



Modified at {{ file.mtime }}
