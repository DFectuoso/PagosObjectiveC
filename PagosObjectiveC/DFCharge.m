#import "DFcharge.h"

#import "DFToken.h"
#import "DFClient.h"

@implementation DFCharge

@synthesize conektaId, livemode, createdAt, status, currency, description, referenceId, failureCode, failureMessage, amount, cardToken, customer;

- (NSData*) asJSONData{
    NSString* paramString = [NSString stringWithFormat:@"{ \
                             \"description\":\"%@\",\
                             \"amount\": %@,\
                             \"currency\":\"%@\",\
                             \"reference_id\":\"%@\",\
                             \"card\": \"%@\"\
                             \"customer\": \"%@\"\
                             }", self.description, self.amount,self.currency,self.referenceId,self.cardToken.conektaId, self.customer.conektaId];
    
    NSLog(@"ATTRIBUTOS: %@", paramString);
    
    return [paramString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
{ '{
    "description":"Test charge from iOS",
    "amount": 5000,
    "currency":"MXN",
    "reference_id":"RBSWFy0xySF1bBGvG7eg",
    "card": "card_1w9H68e2syS6TWa3"
    "customer": "cus_pnMQwjUzwa9jRU3sm"
}': '' }