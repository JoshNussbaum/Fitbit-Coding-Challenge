//
//  Utilities.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/17/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSString *)getDateStringWithoffset:(NSInteger)offset format:(NSInteger)format{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:(-offset)];
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateformater=[[NSDateFormatter alloc]init];
    
    NSString *formatString;
    switch (format) {
        case MONTH_FIRST_THREE_LETTERS:
            formatString = @"MMM";
            break;
        case DAY_NUMBERS:
            formatString = @"dd";
            break;
        case MONTH_LETTERS_AND_DAY_NUMBERS:
            formatString = @"MMM dd";
            break;
        case DAY_MONTH_YEAR:
            formatString = @"dd/MM/YYYY";
            break;
        case MONTH_NUMBERS_AND_DAY_NUMBERS:
            formatString = @"MM/dd";
            break;
        case DAY_FIRST_THREE_LETTERS:
            formatString = @"EEE";
    }
    [dateformater setDateFormat:formatString];
    
    NSString *dateString=[dateformater stringFromDate:date];
    
    
    return dateString;
}



+ (void)makeFakeData:(NSMutableArray *)dataArray{
    NSInteger currentDays = [dataArray count];
    NSInteger target = currentDays + numberOfDays;
    while (currentDays < target){
        NSString *date = [self getDateStringWithoffset:(-currentDays) format:DAY_MONTH_YEAR];
        NSInteger randomSteps = arc4random() % 9000;
        NSDictionary *day = @{@"date": date, @"steps": [NSString stringWithFormat:@"%ld", (long)randomSteps]};
        [dataArray addObject:day];
        currentDays++;
        
    }
}


+ (NSDate *)getDateByOffset:(NSInteger)offset{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:offset];
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    return date;
}


@end
