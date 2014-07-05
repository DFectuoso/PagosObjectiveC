//
//  DFCard.h
//  PagosObjectiveC
//
//  Created by Santiago Zavala de la Vega on 7/5/14.
//  Copyright (c) 2014 Dfectuoso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFCard : NSObject{
    NSString* number;
    NSString* name;
    NSString* cvc;
    NSString* monthExp;
    NSString* yearExp;
}

@property(strong, nonatomic) NSString* number;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* cvc;
@property(strong, nonatomic) NSString* monthExp;
@property(strong, nonatomic) NSString* yearExp;

@end
