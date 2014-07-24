#import "DFcharge.h"

#import "DFToken.h"
#import "DFClient.h"

@implementation DFCharge

@synthesize conektaId, livemode, createdAt, status, currency, description, referenceId, failureCode, failureMessage, amount, cardToken, customer;

- (NSData*) asJSONData{
    NSString* paramString = [NSString stringWithFormat:@"{\
                             \"description\":\"%@\",\
                             \"amount\": %@,\
                             \"currency\":\"%@\",\
                             \"reference_id\":\"%@\",\
                             \"card\": \"%@\",\
                             \"customer\": \"%@\"\
                             }", self.description, self.amount,self.currency,self.referenceId,self.cardToken.conektaId, self.customer.conektaId];
    NSLog(@"ATTRIBUTOS: %@", paramString);
    return [paramString dataUsingEncoding:NSUTF8StringEncoding];
}

@end