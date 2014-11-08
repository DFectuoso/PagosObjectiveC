#import "DFConekta.h"

#import "DFCard.h"
#import "DFCharge.h"
#import "DFToken.h"
#import "DFClient.h"

@implementation DFConekta

NSString *PUBLIC_API_KEY = @"key_EVryd61Uhsq9d6Z2";

@synthesize apiKey, paymentServer;

+ (NSDictionary*)parseJSON:(NSData*) inputData{
    NSError *error;
    
    NSDictionary* boardsDictionary = [NSJSONSerialization JSONObjectWithData:inputData options:NSJSONReadingMutableContainers error:&error];
    
    return boardsDictionary;
}

- (id)initWithApiKey:(NSString*)newApiKey{
    self = [super init];
    if (self) {
        self.apiKey = newApiKey;
    }
    return self;
}

- (NSString*)apiKeyAsBase64{
    NSData* apiKeyBase64Data = [self.apiKey dataUsingEncoding:NSUTF8StringEncoding];
    apiKeyBase64Data = [apiKeyBase64Data base64EncodedDataWithOptions:0];
    
    return [[NSString alloc] initWithData:apiKeyBase64Data encoding:NSUTF8StringEncoding];
}

- (void)tokenizeCard:(DFCard*) card withSuccess:(void (^)(DFToken* token))success fail:(void (^)(NSError* error))fail{
    NSLog(@"Start tokenizing");
    NSURL* url = [NSURL URLWithString:@"https://api.conekta.io/tokens"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request addValue:[NSString stringWithFormat:@"Basic %@", [self apiKeyAsBase64]] forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/vnd.conekta-v0.3.0+json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request addValue:@"{\"agent\":\"Conekta Conekta iOS SDK\"}" forHTTPHeaderField:@"Conekta-Client-User-Agent"];
    
    [request setHTTPBody:[card asJSONData]];
    
    // Async request to avoid UI block.
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {  if(error){
            // Answer with the NSURLSession error, since that is where the request failed
            fail(error);
        } else {
            NSDictionary* answer = [DFConekta parseJSON:data];
            
            if ([[answer objectForKey:@"object"] isEqualToString:@"token"]) {

                DFToken* token = [[DFToken alloc] init];
                [token setConektaId:[answer valueForKey:@"id"]];
                [token setLivemode:[[answer valueForKey:@"livemode"] boolValue]];
                [token setUsed:[[answer valueForKey:@"used"] boolValue]];
                
                NSLog(@"Success: %@", token);
                success(token);

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
}

- (void)simpleCharge:(DFCard*) card charge:(DFCharge*)charge withSuccess:(void (^)(DFCharge* charge))success fail:(void (^)(NSError* error))fail{
    [self tokenizeCard:card withSuccess:^(DFToken* token) {
        [charge setCardToken:token];
        
        NSURL* url = [NSURL URLWithString:@"https://api.conekta.io/charges"];
        
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        [request addValue:[NSString stringWithFormat:@"Basic %@", [self apiKeyAsBase64]] forHTTPHeaderField:@"Authorization"];
        [request addValue:@"application/vnd.conekta-v0.3.0+json" forHTTPHeaderField:@"Accept"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request addValue:@"{\"agent\":\"Conekta Conekta iOS SDK\"}" forHTTPHeaderField:@"Conekta-Client-User-Agent"];
        
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
        
    } fail:^(NSError* error){
        fail(error);
    }];
}





- (DFClient*) getLocalClient{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"localConektaClient_%@",[self apiKey]]];

	DFClient* client = [DFClient clientWithContentsOfFile:path];
    return client;
}

- (void) clearLocalClient{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"localConektaClient_%@",[self apiKey]]];

    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    if (success) {
        NSLog(@"erased");
    } else {
        NSLog(@"Could not delete %@ file -:%@ ",path, [error localizedDescription]);
    }
}

- (void) setLocalClient:(DFClient*) client{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"localConektaClient_%@",[self apiKey]]];
    
	[client writeToFile:path];
}

@end