//
//  HomeViewController.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/15/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "FlexTableViewCell.h"
#import "NSString+FontAwesome.h"
#import "User.h"
#import "StepsTableViewController.h"
#import "Utilities.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSDictionary *activeDay;
    NSString *currentDate;
    NSInteger dateOffset;
    NSDictionary *fakeUserData;
    NSArray *fakeDaysData;
    User *currentUser;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fakeUserData = @{@"userID": @"1", @"name": @"Josh Nussbaum", @"weight": @"160"};
    fakeDaysData = @[@{@"date": @"15/11/2015", @"steps": @"10", @"miles": @"0.01", @"caloriesBurned": @"20", @"activeMinutes": @"10", @"weight": @"160.2", @"caloriesConsumed": @"1000", @"waterConsumed": @"2l"},@{@"date": @"14/11/2015", @"steps": @"20", @"miles": @"0.02", @"caloriesBurned": @"30", @"activeMinutes": @"10", @"weight": @"160.2", @"caloriesConsumed": @"1000", @"waterConsumed": @"2l"}, @{@"date": @"13/11/2015", @"steps": @"2000", @"miles": @"2.40", @"caloriesBurned": @"1000", @"activeMinutes": @"30", @"weight": @"159.2", @"caloriesConsumed": @"1000", @"waterConsumed": @"2l"}, @{@"date": @"11/11/2015", @"steps": @"423", @"miles": @"0.40", @"caloriesBurned": @"260", @"activeMinutes": @"12", @"weight": @"156.2", @"caloriesConsumed": @"872", @"waterConsumed": @"3l"}, @{@"date": @"08/11/2015", @"steps": @"4567", @"miles": @"3.40", @"caloriesBurned": @"1764", @"activeMinutes": @"82", @"weight": @"154.2", @"caloriesConsumed": @"1000", @"waterConsumed": @"9l"},  @{@"date": @"19/11/2015", @"steps": @"3241", @"miles": @"2.40", @"caloriesBurned": @"2031", @"activeMinutes": @"82", @"weight": @"155.6", @"caloriesConsumed": @"1592", @"waterConsumed": @"3l"}];
    
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:83.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1.0]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:.0f alpha:1.f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    currentUser = [User getInstance];
    currentUser.userID = [fakeUserData objectForKey:@"userId"];
    currentUser.name = [fakeUserData objectForKey:@"name"];
    currentUser.weight = [fakeUserData objectForKey:@"weight"];
    
    activeDay = nil;
    dateOffset = 0;
    [self.rightDayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    
    for (NSDictionary *day in fakeDaysData){
        if ([[day objectForKey:@"date"] isEqualToString:currentDate]){
            activeDay = day;
        }
    }
    [self displayDate];
}

- (IBAction)leftDayClicked:(id)sender {
    dateOffset--;
    [self displayDate];
    [self.rightDayButton setTitleColor:[UIColor colorWithRed:83.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self displayDateData];
    
}


- (IBAction)rightDayClicked:(id)sender {
    if (dateOffset == 0){
        [self.rightDayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else {
        dateOffset++;
        if (dateOffset == 0){
            [self.rightDayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        else{
            [self.rightDayButton setTitleColor:[UIColor colorWithRed:83.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
        [self displayDate];
    }
    [self displayDateData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        FlexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlexCell"];
        [cell initializeWithicon:@"fa-clock-o"];
        return cell;
    }
    else{
        HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
        
        NSNumber *number;
        NSString *body;
        NSString *icon;
        BOOL progressBar;
        BOOL usesNumber;
        
        switch (indexPath.row) {
            case 1:
                number = [activeDay objectForKey:@"steps"];
                body = @"  steps";
                icon = @"fa-paw";
                progressBar = YES;
                usesNumber = YES;
                break;
                
            case 2:
                number = [activeDay objectForKey:@"miles"];
                body = @"  miles";
                icon = @"fa-map-marker";
                progressBar = YES;
                usesNumber = YES;
                break;
                
            case 3:
                number = [activeDay objectForKey:@"caloriesBurned"];
                body = @"  calories burned";
                icon = @"fa-fire";
                progressBar = YES;
                usesNumber = YES;
                break;
                
            case 4:
                number = [activeDay objectForKey:@"activeMinutes"];
                body = @"  active minutes";
                icon = @"fa-bolt";
                progressBar = YES;
                usesNumber = YES;
                break;
                
            case 5:
                number = nil;
                body = @"Track exercise";
                icon = @"fa-male";
                progressBar = NO;
                usesNumber = NO;
                break;
                
            case 6:
                number = [activeDay objectForKey:@"weight"];
                body = @"  lbs";
                icon = @"fa-balance-scale";
                progressBar = NO;
                usesNumber = YES;
                break;
                
            case 7:
                number = nil;
                body = @"How well did you sleep?";
                icon = @"fa-moon-o";
                progressBar = NO;
                usesNumber = NO;
                break;
                
            case 8:
                number = [activeDay objectForKey:@"caloriesConsumed"];
                body = @"  calories eaten";
                icon = @"fa-cutlery";
                progressBar = NO;
                usesNumber = YES;
                break;
                
            case 9:
                number = nil;
                body = @"Start a food plan";
                icon = @"fa-cutlery";
                progressBar = NO;
                usesNumber = NO;
                break;
                
            case 10:
                number = [activeDay objectForKey:@"waterConsumed"];
                body = @"  fl oz";
                icon = @"fa-glass";
                progressBar = YES;
                usesNumber = YES;
                
            default:
                break;
        }
        
        [cell initializeWithnumber:number text:body icon:icon progressBar:progressBar usesNumber:usesNumber];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"dashboard_to_steps" sender:self];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)viewDidLayoutSubviews{
    if ([self.homeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.homeTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.homeTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.homeTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)clearExistingCell:(UITableViewCell *)cell{
    if (cell == nil) return;
    else {
        UIView* subview;
        while ((subview = [[[cell contentView] subviews] lastObject]) != nil)
            [subview removeFromSuperview];
    }
}


- (void)displayDate{
    currentDate = [Utilities getDateStringWithoffset:0 format:DAY_MONTH_YEAR];

    for (NSDictionary *day in fakeDaysData){
        if ([[day objectForKey:@"date"] isEqualToString:currentDate]){
            activeDay = day;
        }
    }
    
    NSDate *date = [Utilities getDateByOffset:dateOffset];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterLongStyle];
    [dateformatter setTimeStyle:NSDateFormatterNoStyle];
    [dateformatter setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *dateString = [dateformatter stringFromDate:date];
    
    self.dateLabel.text = dateString;
}


- (void)displayDateData{
    activeDay = nil;
    currentDate = [Utilities getDateStringWithoffset:(-dateOffset) format:DAY_MONTH_YEAR];
    for (NSDictionary *day in fakeDaysData){
        if ([[day objectForKey:@"date"] isEqualToString:currentDate]){
            activeDay = day;
        }
    }
    [self.homeTableView reloadData];
}

@end
