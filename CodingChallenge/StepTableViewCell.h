//
//  StepTableViewCell.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;

- (void)initializeWithdate:(NSString *)date steps:(NSString *)steps;

@end
