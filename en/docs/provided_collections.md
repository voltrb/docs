## Provided Collections

Above, we mentioned that Volt comes with many default collection models accessible from a controller.  Each stores in a different location.

| Name        | Storage Location                                                   |
|-------------|--------------------------------------------------------------------|
| page        | Temporary store that only lasts for the life of the page.        |
| store       | Syncs data to the backend database and provides query methods. |
| local_store | The browser's local storage.                                  |
| params      | Stores values in the params and URL structure. Routes can be configured to change how params are shown in the URL.  (See routes for more info) |
| flash       | Any strings assigned will be shown at the top of the page and cleared as the user navigates between pages. |
| cookies     | Stores each value in a cookie. You can only assign properties directly, not in sub collections. |
| controller  | A model for the current controller.                                       |

**More storage locations are planned.**

Modified at {{ file.mtime }}
