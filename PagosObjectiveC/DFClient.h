//
//  DFClient.h
//  PagosObjectiveC
//
//  Created by Santiago Zavala de la Vega on 7/5/14.
//  Copyright (c) 2014 Dfectuoso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFClient : NSObject{
    NSString* conektaId;
    NSString* name;
    NSString* email;
    NSString* phone;
    BOOL livemode;
    NSString* defaultCard;
    NSDate* createdAt;
    NSMutableArray* cards;
//    DFSuscription* suscription; // TODO Implement Suscriptions
}


@property(nonatomic, strong)NSString* conektaId;
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* email;
@property(nonatomic, strong)NSString* phone;
@property BOOL livemode;
@property(nonatomic, strong)NSString* defaultCard;
@property(nonatomic, strong)NSDate* createdAt;
@property(nonatomic, strong)NSMutableArray* cards;
//@property(nonatomic, strong) DFSuscription* suscription;

+(DFClient*) clientWithContentsOfFile: (NSString*) path;

- (void)encodeWithCoder:(NSCoder*)coder;
- (void)writeToFile:(NSString*)path;
- (id)initWithCoder:(NSCoder*)coder;

@end
