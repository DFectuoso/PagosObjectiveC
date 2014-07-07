//
//  DFToken.h
//  PagosObjectiveC
//
//  Created by Santiago Zavala de la Vega on 7/5/14.
//  Copyright (c) 2014 Dfectuoso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFToken : NSObject{
    NSString* conektaId;
    BOOL livemode;
    BOOL used;
}

@property(nonatomic, strong) NSString* conektaId;
@property BOOL livemode;
@property BOOL used;

@end
