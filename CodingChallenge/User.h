//
//  User.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/14/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSNumber *userID;
    NSString *name;
    NSNumber *weight;
}

@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *weight;

+ (id)getInstance;


@end
