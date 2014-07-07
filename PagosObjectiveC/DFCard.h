#import <Foundation/Foundation.h>

@class DFToken;

@interface DFCard : NSObject{
    NSString* conektaId;
    NSString* last4;
    NSString* brand;
    BOOL active;
    /// DFAddress* address; // TODO IMPLEMENT ADDRESS
    
    NSString* number;
    NSString* name;
    NSString* cvc;
    NSString* monthExp;
    NSString* yearExp;
}

@property(strong, nonatomic) NSString* conektaId;
@property(strong, nonatomic) NSString* brand;
@property(strong, nonatomic) NSString* last4;
@property BOOL active;

@property(strong, nonatomic) NSString* number;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* cvc;
@property(strong, nonatomic) NSString* monthExp;
@property(strong, nonatomic) NSString* yearExp;

- (NSData*) asJSONData;
- (DFToken*) asToken;

@end
