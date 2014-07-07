#import <Foundation/Foundation.h>

@class DFToken;
@class DFClient;

@interface DFCharge : NSObject{
    NSString* conektaId;
    BOOL livemode;
    NSDate* createdAt;
    NSString* status;
    NSString* currency;
    NSString* description;
    NSString* referenceId;
    NSInteger failureCode;
    NSString* failureMessage;
    NSString* amount;
    
    DFToken* cardToken;
    DFClient* customer;
}

@property(nonatomic, strong) NSString* conektaId;
@property(nonatomic, strong) NSDate* createdAt;
@property(nonatomic, strong) NSString* status;
@property(nonatomic, strong) NSString* currency;
@property(nonatomic, strong) NSString* description;
@property(nonatomic, strong) NSString* referenceId;
@property(nonatomic, strong) NSString* failureMessage;
@property(nonatomic, strong) NSString* amount;

@property(nonatomic, strong) DFToken* cardToken;
@property(nonatomic, strong) DFClient* customer;

@property NSInteger failureCode;
@property BOOL livemode;

- (NSData*) asJSONData;

@end
