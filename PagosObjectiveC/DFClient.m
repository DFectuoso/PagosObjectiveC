//
//  DFClient.m
//  PagosObjectiveC
//
//  Created by Santiago Zavala de la Vega on 7/5/14.
//  Copyright (c) 2014 Dfectuoso. All rights reserved.
//

#import "DFClient.h"

@implementation DFClient

@synthesize name, email, phone, conektaId, livemode, defaultCard, createdAt, cards;

+(DFClient*) clientWithContentsOfFile: (NSString*) path {
    NSData *data = [[NSData alloc] initWithContentsOfFile: path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];
    DFClient *client = [unarchiver decodeObjectForKey:@"ConektaClient"];
    [unarchiver finishDecoding];
    
    return client;
}

- (void)writeToFile:(NSString*)path{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData: data];
    [archiver encodeObject: self forKey:@"ConektaClient"];
    [archiver finishEncoding];
    [data writeToFile: path atomically: YES];
}

-(void) encodeWithCoder: (NSCoder*) coder {
    [coder encodeObject:@"1.0" forKey:@"version"];
    [coder encodeObject:conektaId forKey:@"conektaId"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:email forKey:@"email"];
    [coder encodeObject:phone forKey:@"phone"];
    [coder encodeBool:livemode forKey:@"livemode"];
    [coder encodeObject:defaultCard forKey:@"defaultCard"];
    [coder encodeObject:createdAt forKey:@"createdAt"];
    [coder encodeObject:cards forKey:@"cards"];
}

-(id) initWithCoder: (NSCoder*) coder {
    self = [super init];
    if ( ! self) return nil;
    
    conektaId = [coder decodeObjectForKey:@"conektaId"];
    name = [coder decodeObjectForKey:@"name"];
    email = [coder decodeObjectForKey:@"email"];
    phone = [coder decodeObjectForKey:@"phone"];
    livemode = [coder decodeBoolForKey:@"livemode"];
    defaultCard = [coder decodeObjectForKey:@"defaultCard"];
    createdAt = [coder decodeObjectForKey:@"createdAt"];
    cards = [coder decodeObjectForKey:@"cards"];

    return self;
}

@end
