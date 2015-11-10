# Colección Flash

La colección flash te permite mostrar información al usuario(del lado del cliente) de manera mas fácil. Flash contiene 4 ArrayModel por default : ```successes``` , ```notices```, ```warnings``` y ```errors```. Cuando se añaden mensajes, estos son mostrados en un div con las clases respectivas ```"alert alert-{{ ..collection name.. }}"```

### Ejemplo

```ruby
flash._successes << "Your data has been saved"
```

```ruby
flash._errors << "Unable to save because you're not on the internet"
```

Los strings añadidos a cualquier subcolección de flash serán removidos después de 5 segundos. El usuario puede remover el mensaje flash haciendo simplente haciendo click.

# Colección de Store Local

La colección ```local_store``` guarda los datos en el store local del browser

# Colección de cookies

La colección ```cookies``` guarda los datos en una cookie del browser. Cada propiedad asignada es guardada en el cookie de la misma forma:

```ruby
cookies._user_id = 520

puts cookie._user_id
# => "520"

cookies.delete(:user_id)
```

Los valores en la colección cookie son convertidos a strings. Todavía no se puede añadir un tiempo de expiración para estos datos. Por ahora los cookies tiene un tiempo de expiración de un año.
