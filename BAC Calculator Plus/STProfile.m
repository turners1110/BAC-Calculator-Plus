//
//  STProfile.m
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/27/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import "STProfile.h"

@implementation STProfile

-(id)initWithWeight: (NSString *)weight forAge:(NSString *)age forMetric: (float)metric andMALE: (float)MALE;

{
    self = [super init];
    if (self) {
        _weight = weight;
        _age = age;
        _metric = metric;
        _MALE = MALE;
        
    }
    return self;
}

@end
