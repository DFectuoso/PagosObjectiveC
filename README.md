## Intro

Conekta iOS SDK is a base of App to tokenize Credit/Debit Cards using Conekta REST API
and make Payments with tokens, create Customers and save the tokens to Customers for
future charges.

## Table of Contents

- Intro
- Requeriments
- Installation
- Configuration and Setup
- Contributing & Attribution
- License

## Requirements
- Clone the repo to your Mac``git clone git@github.com:javiermurillo/PagosObjectiveC.git``

###### To create Tokens and make Payments directly to REST API:
- Xcode 5 or superior.

###### To create Customers and save cards (tokens) in Customer:
- PaymentServer to resolve requests and process to Conekta REST API. (ex.``git clone git@github.com:javiermurillo/PagosObjectiveC.git``)


## Configuration and Setup

### Initial Configuration in XCode

1. Go to ``PagosObjectiveC/DFConekta.m`` at the line 10, put your Conekta Public Key ([admin.conekta.io](https://admin.conekta.io/en#developers.keys)):
``NSString *PUBLIC_API_KEY = @"key_XXXXxxxxXXXXxxxx";``

2. Run and Compile the Project, you can use "Payment to Conekta API", this option tokenize the credit/debit card and make one payment
directly to Conekta REST API (https://api.conekta.io/charges)

![Payment to Conekta REST API](https://raw.github.com/javiermurillo/PagosObjectiveC/master/readme_files/pay_to_api_conekta.gif)

### Config to create Customers and Charge on-demand.

If you want to use Charge on-demand, create Customers, you need to complete next steps and use/implement PaymentServer and complete next:


1. Go to ``PagosObjectiveC/DFPaymentServer.m`` at the line 12 put the URL to make requests to your PaymentServer:
``NSString *PAYMENT_SERVER_URL = @"http://url-para-payment-server.dominio";``, if you want to make a few tests, you can use your local
 PaymentServer, ex:  ``http://127.0.0.1:3000``

2. You can use this example in Node [PaymentServer](https://github.com/javiermurillo/NodePaymentserver) to solve the request at ``http://127.0.0.1:3000``.

![alt tag](https://raw.github.com/javiermurillo/PagosObjectiveC/master/readme_files/customer_payment.gif)


### Routes of PaymentServer

if you are using your own endpoint or another PaymentServer, is important define the routes at ``PagosObjectiveC/DFPaymentServer.m``

````
- (id)initWithBaseUrl:(NSString*)newBaseUrl{
    self = [super init];
    if (self) {
        baseUrl = newBaseUrl;
        createClientUrl = @"/client/create";
        addCardToClientUrl = @"/client/addCard";
        chargeUrl = @"/charge";
    }
    return self;
}
````

#### /client/create

At this route is creating the request to your PaymentServer to create a Customer at Conekta, you can change the route, at this time, is creating an empty Customer, but you can add the method to create customer with his right credentials.

#### /client/addCard

This route is adding a card to a Customer, the Customer previusly created from App (Conekta iOS SDK), the card is assigned to Customer ID as a token.

#### /charge

Whit this route, we are sending a Charge on-demand to our PaymentServer, from this server is requested to Conekta REST API to make the charge.

### What is a Customer?

Customers allow you to store cards for clients and set up subscriptions, you can get more information at [Customer at Conekta REST API](https://www.conekta.io/en/docs/api#customers)

## Contributing & Attribution

Thanks to [Santiago Zavala](https://github.com/dfectuoso) for helping us to create Conekta iOS SDK and [Javier Murillo](https://github.com/javiermurillo) to write the README.

License
-------
Developed by [Conekta](https://www.conekta.io). Available with [MIT License](LICENSE).
