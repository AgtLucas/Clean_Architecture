Buenas a todos,

Desde el equipo de Madrid se ha pedido que actualicemos la librería PUSH y el proyecto para hacer las pruebas de la plataforma PUSH de TEST (sí, hay una aplicación que hizo Antonio Fiñana, que se basa en un cliente muy sencillo que realiza un registro/desregistro y acknowledges a la plataforma PUSH de TEST). 

Las tareas a realizar son:

* Actualizar el proyecto para que use la última versión de la librería, y haga las siguientes acciones: registro, desregistro, acknowledge de las diferentes recepciones de notificaciones push.
* Generar documentación de la librería PUSH actual, para que pueda ser ofrecida a posibles clientes.

A modo opcional, se podría añadir en la librería una forma de controlar el identificador para usuarios anónimos y el token antiguo en el Keychain como habíamos discutido. De forma que internamente, podamos preguntar por un idenificador de usuario anónimo, y la librería se encargue de buscarlo en el keychain, o en caso de que no exista de autogenerarlo y guardarlo posteriormente.

También se ha mencionado que se añada a la documentación que las aplicaciones deberían registrarse cada vez que se encienden para refrescar el token en la base de datos de la plataforma PUSH si ésta decide expirar los tokens más antiguos.

