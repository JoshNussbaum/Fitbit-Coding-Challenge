//
//  Utilities.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/17/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger MONTH_FIRST_THREE_LETTERS = 1;
static const NSInteger DAY_NUMBERS = 2;
static const NSInteger MONTH_LETTERS_AND_DAY_NUMBERS = 3;
static const NSInteger DAY_MONTH_YEAR = 4;
static const NSInteger MONTH_NUMBERS_AND_DAY_NUMBERS = 5;
static const NSInteger DAY_FIRST_THREE_LETTERS = 6;

static const NSInteger numberOfDays = 50;

@interface Utilities : NSObject

+ (void)makeFakeData:(NSMutableArray *)dataArray;

+ (NSString *)getDateStringWithoffset:(NSInteger)offset format:(NSInteger)format;

+ (NSDate *)getDateByOffset:(NSInteger)offset;

@end
