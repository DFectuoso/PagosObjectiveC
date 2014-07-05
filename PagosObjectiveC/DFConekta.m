#import "DFConekta.h"

#import "DFCard.h"
#import "DFPayment.h"

@implementation DFConekta

@synthesize apiKey;

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

- (void)tokenizeCard:(DFCard*) card withSuccess:(void (^)(id JSON))success fail:(void (^)(void))fail{

}

- (void)simpleCharge:(DFCard*) card payment:(DFPayment*)payment withSuccess:(void (^)(id JSON))success fail:(void (^)(void))fail{

}

@end