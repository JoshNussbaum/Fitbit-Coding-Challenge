//
//  FlexTableViewCell.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "FlexTableViewCell.h"
#import "NSString+FontAwesome.h"

@implementation FlexTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializeWithicon:(NSString *)icon{
    self.iconLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    
    self.iconLabel.text = [NSString fontAwesomeIconStringForIconIdentifier:icon];
}

@end
