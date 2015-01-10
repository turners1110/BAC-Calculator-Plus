//
//  STProfile.h
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/27/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STProfile : NSObject
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *gender;
@property float metric;
@property float MALE;

-(id)initWithWeight: (NSString *)weight forAge:(NSString *)age forMetric: (float)metric andMALE: (float)MALE;

@end
