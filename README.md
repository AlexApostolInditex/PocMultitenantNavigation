Proyecto de PoC: Queremos un workspace donde tengamos una host app, y dos módulos:

- Módulo de flujo de Checkout:
  - Pantalla carrito
  - Pantalla método de envío
  - Pantalla resumen
- Módulo de Login:
  - Pantalla de login
  - Pantalla de registro

- El usuario "guest" puede ver el carrito.
- Cuando el usuario "guest" pulsa en "Continuar":
  - Se presenta la pantalla de Login, que está en otro módulo.
- Si el usuario está logueado:
  - Se le lleva directamente a los métodos de envío y puede seguir el flujo.
- La gestión del tipo de usuario se encuentra en un State Repository.
- La pantalla de Login permite navegar al registro.
- Cuando se realiza un Login exitoso o un Registro exitoso:
  - Se cierra el flujo de Login.
  - Se devuelve el control al flujo de Checkout.
  - Se va a la pantalla de Métodos de envío.
- No se tiene en cuenta el caso de "Comprar como guest".
- Se toma la tienda de España como ejemplo para esta navegación.
- Versión mínima de iOS: iOS 13.

Tarea: https://axinic.central.inditex.grp/jira/browse/CORESERVICES-628

Info: https://khanlou.com/2015/01/the-coordinator/


