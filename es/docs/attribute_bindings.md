# Bindings de Atributo

Los bindings también pueden ser ingresados dentro de atributos

```html
<p class="{{ if is_cool? }}cool{{ end }}">Text</p>
```

## Bindings de atributos de dos vías

Volt nos permite tener elementos que actúan como enlaces de "dos vías":

```html
<input type="text" value="{{ _name }}" />
```

Si la variable ```_name``` cambia, el valor del text-box cambiará automáticamente.  El enlace llama a ```_name``` en el controlador para obtener el valor de esa variable. Cuando un usuario escribe en el text box, su método setter sera invocado en el controlador. En este caso se llamará a ```_name=``` en el controlador y el nuevo valor sera guardado. Esto nos da el efecto de un enlace de dos vías, pero también tienes la capacidad de cambiar como los datos son actualizados ( definiendo otro setter, por ejemplo)

## CheckBoxes

En el siguiente ejemplo, si ```_name``` cambia, el campo se actualizará, y si el campo es actualizado por el usuario, ```_name``` tambien cambiará.

```html
<input type="checkbox" checked="{{ _checked }}" />
```

Si el valor ingresado es ```true```, el checkbox se marcara como checked.  El valor sera marcado o desmarcado si el valor es ```true``` o ```false``` respectivamente.

## Radio Buttons

Los radio buttons también estan enlazados a un estado, solo que en lugar de tener un valor booleano esto se obtienen del valor del campo seleccionado.

```html
<input type="radio" checked="{{ _radio }}" value="one" />
<input type="radio" checked="{{ _radio }}" value="two" />
```

Cuando un valor se selecciona en el radio button, este cambio se verá reflejado a su vez en el campo enlazado, sin importar el valor anterior. Cuando el valor enlazado se cambia, cualquier campo en cualquier radio button que tenga el mismo valor que la variable será marcado.

## Select Boxes

Los select boxes se pueden enlazar a cualquier valor. (esto no lo puedes hacer con html normal, es una característica propia de Volt).

```html
<select value="{{ _rating }}">
  <option value="1">*</option>
  <option value="2">**</option>
  <option value="3">***</option>
  <option value="4">****</option>
  <option value="5">*****</option>
</select>
```

Cuando el valor seleccionado cambia, la variable ```_rating``` también será cambiada. Cuando ```_rating``` cambia el valor seleccionado es cambiado con el primer valor que concuerde. Si no se encuentra ningún valor en el select box este se marca como no seleccionado.
