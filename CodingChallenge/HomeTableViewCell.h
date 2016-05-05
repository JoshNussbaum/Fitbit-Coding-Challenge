//
//  HomeTableViewCell.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *iconLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

- (void)initializeWithnumber:(NSNumber *)number text:(NSString *)text icon:(NSString *)icon progressBar:(BOOL)progressBar usesNumber:(BOOL)usesNumber;

@end
