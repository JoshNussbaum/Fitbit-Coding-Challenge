//
//  Day.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/14/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSNumber *steps;

@property (nonatomic, strong) NSNumber *miles;

@property (nonatomic, strong) NSNumber *caloriesBurned;

@property (nonatomic, strong) NSNumber *activeMinutes;

@property (nonatomic, strong) NSNumber *weight;

@property (nonatomic, strong) NSNumber *caloriesConsumed;

@property (nonatomic, strong) NSNumber *waterConsumed;


- (id)initWithDictionary:(NSDictionary *)dayDictionary;


@end
