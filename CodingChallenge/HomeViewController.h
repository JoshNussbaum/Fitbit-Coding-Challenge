//
//  HomeViewController.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/15/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *leftDayButton;
@property (weak, nonatomic) IBOutlet UIButton *rightDayButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

- (IBAction)leftDayClicked:(id)sender;

- (IBAction)rightDayClicked:(id)sender;


@end
