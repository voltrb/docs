## Provided Collections

Above, we mentioned that Volt comes with many default collection models accessible from a controller.  Each stores in a different location.

| Name        | Storage Location                                                          |
|-------------|---------------------------------------------------------------------------|
| page        | Page provides a temporary store that only lasts for the life of the page. |
| store       | Store syncs the data to the backend database and provides query methods.  |
| local_store | Values will be stored in the local_store.                                 |
| params      | Values will be stored in the params and URL.  Routes can be setup to change how params are shown in the URL.  (See routes for more info) |
| flash       | Any strings assigned will be shown at the top of the page and cleared as the user navigates between pages. |
| cookies     | Saves as a cookie, only assign properties directly, not sub collections. |
| controller  | A model for the current controller.                                       |

**More storage locations are planned.**
