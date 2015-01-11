## Provided Collections

Above, we mentioned that Volt comes with many default collection models accessible from a controller.  Each stores in a different location.

| Name        | Storage Location                                                          |
|-------------|---------------------------------------------------------------------------|
| page        | page provides a temporary store that only lasts for the life of the page. |
| store       | store syncs the data to the backend database and provides query methods.  |
| local_store | values will be stored in the local_store                                  |
| params      | values will be stored in the params and URL.  Routes can be setup to change how params are shown in the URL.  (See routes for more info) |
| flash       | any strings assigned will be shown at the top of the page and cleared as the user navigates between pages. |
| cookies     | saves as a cookie, only assign properties directly, not sub collections. |
| controller  | a model for the current controller                                        |

**more storage locations are planned**
