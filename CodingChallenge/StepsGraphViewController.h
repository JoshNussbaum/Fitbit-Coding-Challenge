//
//  StepsGraphViewController.h
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/17/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface StepsGraphViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate, CPTPlotSpaceDelegate>

@property (strong, nonatomic) IBOutlet CPTGraphHostingView *graphView;

- (void)setData:(NSMutableArray *)data;

@end
