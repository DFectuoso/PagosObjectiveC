## Configuración Inicial para SimplePayment

1. Clonar el proyecto ``git clone repositorio`` y abrir con Xcode.

2. Ir al archivo ``PagosObjectiveC/DFConekta.m`` en la línea 10 colocar tu llave pública de Conekta (admin.conekta.io):
``NSString *PUBLIC_API_KEY = @"key_XXXXxxxxXXXXxxxx";``

3. Al abrir la aplicación puedes hacer SimplePayment



## Configuración para Crear Customers y Charge on-demand.

Si quieres utilizar  Charge on-demand, crear Customers, es importante completar la Configuración Inicial para hacer SimplePayment
y agregar lo siguiente:

1. Ir al archivo ``PagosObjectiveC/DFPaymentServer.m`` en la línea 12 colocar el URL para tu PaymentServer:
``NSString *PAYMENT_SERVER_URL = @"http://url-para-payment-server.dominio";``, al momento de hacer pruebas puedes
apuntarlo a tu PaymentServer Local, por ejemplo:  ``http://127.0.0.1:3000``

2. Puedes utilizar este ejemplo en Node del [PaymentServer](https://github.com/javiermurillo/NodePaymentserver) para resolver los request de iOS.

## ¿Qué se hace desde iOS?

1. Se tokeniza la tarjeta

2. Se hacen llamadas a un Servidor que se encarga de procesar: Charges, Customers, Plans, Subscriptions, Charge on-demand,
directamente a los servidores de Conekta.

3. Se realizan cargos simples utilizando el token.

## Tokenizar

Desde iOS se introducen los datos de la tarjeta y son enviados
