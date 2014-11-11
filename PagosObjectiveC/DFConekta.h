#import <Foundation/Foundation.h>

@class DFCard;
@class DFCharge;
@class DFToken;
@class DFClient;
@class DFPaymentServer;

@interface DFConekta : NSObject{
    NSString* apiKey;
    DFPaymentServer* paymentServer;
}

extern NSString *PUBLIC_API_KEY;

@property(strong, nonatomic) NSString* apiKey;
@property(strong, nonatomic) DFPaymentServer* paymentServer;

+ (NSDictionary*)parseJSON:(NSData*) inputData;

- (id)initWithApiKey:(NSString*)newApiKey;

- (NSString*)apiKeyAsBase64;
- (void)tokenizeCard:(DFCard*) card withSuccess:(void (^)(DFToken* token))success fail:(void (^)(NSError* error))fail;
- (void)simpleCharge:(DFCard*) card charge:(DFCharge*)charge withSuccess:(void (^)(DFCharge* charge))success fail:(void (^)(NSError* error))fail;

- (DFClient*) getLocalClient;
- (void) clearLocalClient;
- (void) setLocalClient:(DFClient*) client;

@end
