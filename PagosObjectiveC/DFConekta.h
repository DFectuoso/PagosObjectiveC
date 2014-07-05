#import <Foundation/Foundation.h>

@class DFCard;
@class DFPayment;

@interface DFConekta : NSObject{
    NSString* apiKey;
}

@property(strong, nonatomic) NSString* apiKey;

+ (NSDictionary*)parseJSON:(NSData*) inputData;

- (id)initWithApiKey:(NSString*)newApiKey;
- (NSString*)apiKeyAsBase64;
- (void)tokenizeCard:(DFCard*) card withSuccess:(void (^)(id JSON))success fail:(void (^)(void))fail;
- (void)simpleCharge:(DFCard*) card payment:(DFPayment*)payment withSuccess:(void (^)(id JSON))success fail:(void (^)(void))fail;

@end
