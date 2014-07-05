//
//  DFPayment.h
//  PagosObjectiveC
//
//  Created by Santiago Zavala de la Vega on 7/5/14.
//  Copyright (c) 2014 Dfectuoso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFPayment : NSObject{
    NSString* description;
    NSString* amount;
    NSString* currency;
    NSString* referenceId;
}

@property(nonatomic, strong) NSString* description;
@property(nonatomic, strong) NSString* amount;
@property(nonatomic, strong) NSString* currency;
@property(nonatomic, strong) NSString* referenceId;

@end
