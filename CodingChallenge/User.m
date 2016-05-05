//
//  User.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/14/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userID;
@synthesize name;
@synthesize weight;


+(id)getInstance{
    static User *sharedUser = nil;
    @synchronized(self) {
        if (sharedUser == nil){
            sharedUser = [User new];
        }
    }
    return sharedUser;
}

@end
