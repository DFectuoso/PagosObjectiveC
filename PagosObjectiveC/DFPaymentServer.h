#import <Foundation/Foundation.h>

@class DFClient;
@class DFCard;
@class DFToken;
@class DFClient;
@class DFCharge;

@interface DFPaymentServer : NSObject{
    NSString* baseUrl;
    NSString* createClientUrl;
    NSString* addCardToClientUrl;
    NSString* chargeUrl;
}

@property(nonatomic,strong)NSString* baseUrl;
@property(nonatomic,strong)NSString* createClientUrl;
@property(nonatomic,strong)NSString* addCardToClientUrl;
@property(nonatomic,strong)NSString* chargeUrl;

- (id)initWithBaseUrl:(NSString*)newBaseUrl;

- (void)generateNewClientWithSuccess:(void (^)(DFClient* client))success fail:(void (^)(NSError* error))fail;
- (void)addCardToken:(DFToken*)cardToken toClient:(DFClient*)client withSuccess:(void (^)(DFCard* card))success fail:(void (^)(NSError* error))fail;
- (void)chargeCustomer:(DFClient*)customer withCard:(DFCard*) card charge:(DFCharge*)charge withSuccess:(void (^)(DFCharge* charge))success fail:(void (^)(NSError* error))fail;

@end