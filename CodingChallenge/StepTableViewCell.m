//
//  StepTableViewCell.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "StepTableViewCell.h"

@implementation StepTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializeWithdate:(NSString *)date steps:(NSString *)steps{
    self.dateLabel.text = date;
    self.stepsLabel.text = [NSString stringWithFormat:@"%@ steps", steps];
}

@end
