#import "DFCard.h"

#import "DFToken.h"

@implementation DFCard

@synthesize name, number, cvc, yearExp, monthExp, conektaId, last4, active, brand;

// CVC as string to allow CVCs that start with 0. 
- (NSData*) asJSONData{
    NSString* paramString = [NSString stringWithFormat:@"{\"card\": \
                             { \
                                \"name\": \"%@\",\
                                \"number\": %@,\
                                \"cvc\": \"%@\",\
                                \"exp_month\": %@,\
                                \"exp_year\": %@\
                             }}", self.name, self.number,self.cvc,self.monthExp,self.yearExp];
    return [paramString dataUsingEncoding:NSUTF8StringEncoding];
}

- (DFToken*) asToken{
    DFToken* t = [[DFToken alloc] init];
    t.conektaId = self.conektaId;
    return t;
}

-(void) encodeWithCoder: (NSCoder*) coder {
    [coder encodeObject:conektaId forKey:@"conektaId"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:number forKey:@"number"];
    [coder encodeObject:cvc forKey:@"cvc"];
    [coder encodeObject:yearExp forKey:@"yearExp"];
    [coder encodeObject:monthExp forKey:@"monthExp"];
    [coder encodeObject:last4 forKey:@"last4"];
    [coder encodeObject:brand forKey:@"brand"];
    [coder encodeBool:active forKey:@"active"];
}

-(id) initWithCoder: (NSCoder*) coder {
    self = [super init];
    if ( ! self) return nil;
    
    active = [coder decodeBoolForKey:@"active"];

    conektaId = [coder decodeObjectForKey:@"conektaId"];
    name = [coder decodeObjectForKey:@"name"];
    number = [coder decodeObjectForKey:@"number"];
    cvc = [coder decodeObjectForKey:@"cvc"];
    yearExp = [coder decodeObjectForKey:@"yearExp"];
    monthExp = [coder decodeObjectForKey:@"monthExp"];
    last4 = [coder decodeObjectForKey:@"last4"];
    brand = [coder decodeObjectForKey:@"brand"];
    
    
    return self;
}

@end
