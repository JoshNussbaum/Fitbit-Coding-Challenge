//
//  Day.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/14/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "Day.h"

@implementation Day

- (id)initWithDictionary:(NSDictionary *)dayDictionary{
    self = [super init];
    if (self){
        self->_date = [dayDictionary valueForKey:@"date"];
        self->_steps = [dayDictionary valueForKey:@"steps"];
        self->_miles = [dayDictionary valueForKey:@"miles"];
        self->_caloriesBurned = [dayDictionary valueForKey:@"caloriesBurned"];
        self->_activeMinutes = [dayDictionary valueForKey:@"activeMinutes"];
        self->_weight = [dayDictionary valueForKey:@"weight"];
        self->_caloriesConsumed = [dayDictionary valueForKey:@"caloriesConsumed"];
        self->_waterConsumed = [dayDictionary valueForKey:@"waterConsumed"];
    }
    return self;
}

@end
