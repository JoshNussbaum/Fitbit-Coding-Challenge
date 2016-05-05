//
//  HomeTableViewCell.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "NSString+FontAwesome.h"
#import "User.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializeWithnumber:(NSNumber *)number text:(NSString *)text icon:(NSString *)icon progressBar:(BOOL)progressBar usesNumber:(BOOL)usesNumber{
    
    User *currentUser = [User getInstance];
    
    self.iconLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    
    self.iconLabel.text = [NSString fontAwesomeIconStringForIconIdentifier:icon];
    
    self.bodyLabel.text = text;
    
    if (number != nil){
        if ([text isEqualToString:@"miles"] || [text isEqualToString:@"lbs"]){
            self.numberLabel.text = [NSString stringWithFormat:@"%.02f", [number floatValue]];
        }
        else{
            self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
        }
        
    }
    else {
        if ([text isEqualToString:@"lbs"]){
            self.numberLabel.text = [NSString stringWithFormat:@"%.01f", [currentUser.weight floatValue]];

        }
        else if (usesNumber){
            self.numberLabel.text = @"0";
        }
        else {
            self.numberLabel.text = nil;
        }
    }
    
    if (progressBar) self.progressBar.hidden = NO;
    else self.progressBar.hidden = YES;
    
}

@end
