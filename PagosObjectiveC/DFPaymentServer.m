#import "DFPaymentServer.h"
#import "DFClient.h"
#import "DFConekta.h"
#import "DFToken.h"
#import "DFCard.h"
#import "DFCharge.h"

@implementation DFPaymentServer

@synthesize baseUrl, createClientUrl, addCardToClientUrl, chargeUrl;

NSString *PAYMENT_SERVER_URL = @"http://127.0.0.1:3000";

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

- (void) generateNewClientWithSuccess:(void (^)(DFClient* client))success fail:(void (^)(NSError* error))fail{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseUrl, createClientUrl]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    [request setHTTPBody:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            // Answer with the NSURLSession error, since that is where the request failed
            fail(error);
        } else {
            NSDictionary* answer = [DFConekta parseJSON:data];
            
            if ([[answer objectForKey:@"object"] isEqualToString:@"customer"]) {
                
                DFClient* client = [[DFClient alloc] init];
                
                client.name = [answer valueForKey:@"name"];
                client.email = [answer valueForKey:@"email"];
                client.phone = [answer valueForKey:@"phone"];
                client.cards = [answer valueForKey:@"cards"];
                client.conektaId = [answer valueForKey:@"id"];
                client.defaultCard = [answer valueForKey:@"defaul_card"];
                client.livemode = [[answer valueForKey:@"livemode"] boolValue];
                
                [client setCreatedAt:[NSDate dateWithTimeIntervalSince1970:[[answer valueForKey:@"created_at"] integerValue]]];
                
                success(client);
            } else {
                NSLog(@"%@", answer);
                // Sometime the error is <null>, so we have to default the code to 0 in that case
                NSInteger code;
                if ([answer valueForKey:@"code"] == [NSNull null]) {
                    code = 0;
                } else {
                    code = [[answer valueForKey:@"code"] integerValue];
                }
                
                // Create the error
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: [answer objectForKey:@"message"],
                                           NSLocalizedFailureReasonErrorKey: [answer objectForKey:@"message_to_purchaser"],
                                           };
                
                NSError *error = [NSError errorWithDomain:@"ConektaError"
                                                     code:code
                                                 userInfo:userInfo];
                
                // Send the fail error we created, not the one from NSURLSession, since it didn't really fail there
                fail(error);
            }
            
        }
    }];
    
    [task resume];
}

- (void)addCardToken:(DFToken*)cardToken toClient:(DFClient*)client withSuccess:(void (^)(DFCard* card))success fail:(void (^)(NSError* error))fail{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseUrl, addCardToClientUrl]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[[NSString stringWithFormat:@"{\"token\":\"%@\",\"clientId\":\"%@\"}",cardToken.conektaId, client.conektaId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            // Answer with the NSURLSession error, since that is where the request failed
            fail(error);
        } else {
            NSDictionary* answer = [DFConekta parseJSON:data];
            
            if ([[answer objectForKey:@"object"] isEqualToString:@"card"]) {
                
                DFCard* card = [[DFCard alloc] init];
                
                card.conektaId = [answer valueForKey:@"id"];
                card.active = [[answer valueForKey:@"active"] boolValue];
                card.last4 = [answer valueForKey:@"last4"];
                card.name = [answer valueForKey:@"name"];
                card.monthExp = [answer valueForKey:@"exp_month"];
                card.yearExp = [answer valueForKey:@"exp_year"];

                success(card);
            } else {
                // Conekta has a bug, sometime the error is <null>, so we have to default the code to 0 in that case
                NSInteger code;
                if ([answer valueForKey:@"code"] == [NSNull null]) {
                    code = 0;
                } else {
                    code = [[answer valueForKey:@"code"] integerValue];
                }
                
                // Create the error
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: [answer objectForKey:@"message"],
                                           NSLocalizedFailureReasonErrorKey: [answer objectForKey:@"message_to_purchaser"],
                                           };
                
                NSError *error = [NSError errorWithDomain:@"ConektaError"
                                                     code:code
                                                 userInfo:userInfo];
                
                // Send the fail error we created, not the one from NSURLSession, since it didn't really fail there
                fail(error);
            }
            
        }
    }];
    
    [task resume];
}

- (void)chargeCustomer:(DFClient*)customer withCard:(DFCard*) card charge:(DFCharge*)charge withSuccess:(void (^)(DFCharge* charge))success fail:(void (^)(NSError* error))fail{
    [charge setCardToken:card.asToken];
    [charge setCustomer:customer];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseUrl, chargeUrl]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:[charge asJSONData]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            // Answer with the NSURLSession error, since that is where the request failed
            fail(error);
        } else {
            NSDictionary* answer = [DFConekta parseJSON:data];
            
            if ([[answer objectForKey:@"object"] isEqualToString:@"charge"]) {
                NSLog(@"Got a full charge: %@", answer);
                
                DFCharge* charge = [[DFCharge alloc] init];
                
                [charge setConektaId:[answer valueForKey:@"id"]];
                [charge setLivemode:[[answer valueForKey:@"livemode"] boolValue]];
                [charge setCreatedAt:[NSDate dateWithTimeIntervalSince1970:[[answer valueForKey:@"created_at"] integerValue]]];
                [charge setStatus:[answer valueForKey:@"status"]];
                [charge setCurrency:[answer valueForKey:@"currency"]];
                [charge setDescription:[answer valueForKey:@"description"]];
                [charge setReferenceId:[answer valueForKey:@"reference_id"]];
                if ([answer valueForKey:@"failure_code"] == [NSNull null]) {
                    [charge setFailureCode:0];
                } else {
                    [charge setFailureCode:[[answer valueForKey:@"failure_code"] integerValue]];
                }
                [charge setFailureMessage:[answer valueForKey:@"failure_message"]];
                [charge setAmount:[answer valueForKey:@"amount"]];
                
                success(charge);
            } else {
                
                // Conekta has a bug, sometime the error is <null>, so we have to default the code to 0 in that case
                NSInteger code;
                if ([answer valueForKey:@"code"] == [NSNull null]) {
                    code = 0;
                } else {
                    code = [[answer valueForKey:@"code"] integerValue];
                }
                
                // Create the error
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: [answer objectForKey:@"message"],
                                           NSLocalizedFailureReasonErrorKey: [answer objectForKey:@"message_to_purchaser"],
                                           };
                
                NSError *error = [NSError errorWithDomain:@"ConektaError"
                                                     code:code
                                                 userInfo:userInfo];
                
                // Send the fail error we created, not the one from NSURLSession, since it didn't really fail there
                fail(error);
            }
            
        }
    }];
    
    [task resume];
}

@end
