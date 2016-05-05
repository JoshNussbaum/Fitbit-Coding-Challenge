//
//  FlexTableViewCell.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlexTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *iconLabel;

- (void)initializeWithicon:(NSString *)icon;

@end
