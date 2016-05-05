//
//  StepsTableViewController.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/16/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "StepsTableViewController.h"
#import "StepTableViewCell.h"
#import "Utilities.h"
#import "StepsGraphViewController.h"


@interface StepsTableViewController (){
    NSMutableArray *daysData;
    NSInteger firstWeekLength;
    BOOL firstLoad;
}

@end

@implementation StepsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstLoad = YES;
    daysData = [[NSMutableArray alloc]init];
    [Utilities makeFakeData:daysData];
    firstWeekLength = [self getFirstWeekLength];
}

- (void)setData:(NSMutableArray *)data{
    daysData = data;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger otherDays = [daysData count] - firstWeekLength;
    NSInteger sections = 1 + ceil(otherDays/7);
    return sections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section)
    {
        case 0:
            return firstWeekLength;
        default:
            return 7;
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:111.0/255.0 green:183.0/255.0 blue:187.0/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 100, 16)];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.text=[self getSectionTitleWithsection:section];
    label.textColor = [UIColor whiteColor];
    label.textAlignment=UITextAlignmentLeft;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 130, 4, 120, 16)];
    label2.font = [UIFont boldSystemFontOfSize:12.0f];
    label2.textColor = [UIColor whiteColor];
    label2.text=[self getStepsWithsection:section];
    label2.textAlignment=UITextAlignmentRight;
    
    [sectionView addSubview:label];
    [sectionView addSubview:label2];
    
    return sectionView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StepCell" forIndexPath:indexPath];
    NSInteger offset;
    if (indexPath.section == 0){
        offset = indexPath.row;
    }
    else {
        // I realize it would have made more sense to structure the data
        // as an array of arrays of dictionaries, where each dictionary is a day and each array is a week.
        // Then you could get a week as an array by indexPath.section and a day as a dictionary by indexPath.row
        // Since I finished, however, I'm just going to move on
        offset = firstWeekLength + ((indexPath.section - 1)*7) + indexPath.row;
    }
    NSDictionary *day = [daysData objectAtIndex:offset];
    NSString *steps = [day objectForKey:@"steps"];
    if (offset == 0){
        [cell initializeWithdate:@"Today" steps:steps];
    }
    else if (offset < 7){
        NSString *day = [self getCellDayStringByOffset:offset];
        [cell initializeWithdate:day steps:steps];
    }
    else {
        NSString *day = [Utilities getDateStringWithoffset:offset format:MONTH_NUMBERS_AND_DAY_NUMBERS];
        [cell initializeWithdate:day steps:steps];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"steps_to_graph" sender:self];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    CGFloat actualPosition = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height - (self.tableView.frame.size.height);
    if (actualPosition >= contentHeight) {
        [self addMoreData];
    }
}


- (void)addMoreData{
    if (firstLoad){
        firstLoad = NO;
        return;
    }
    else {
        [Utilities makeFakeData:daysData];
        [self.tableView reloadData];
    }

}


- (NSString *)getCellDayStringByOffset:(NSInteger)offset{
    NSInteger dayInt = [[[NSCalendar currentCalendar] components: NSCalendarUnitWeekday fromDate: [Utilities getDateByOffset:(-offset)]] weekday];
    switch (dayInt) {
        case 1:
            return @"Sunday";
        case 2:
            return @"Monday";
        case 3:
            return @"Tuesday";
        case 4:
            return @"Wednesday";
        case 5:
            return @"Thursday";
        case 6:
            return @"Friday";
        case 7:
            return @"Saturday";
    }
    return nil;
}



- (NSString *)getSectionTitleWithsection:(NSInteger)section{
    NSString *title;
    
    NSInteger firstDayOffset = firstWeekLength + ((section -1)*7);
    NSInteger lastDayOffset = firstDayOffset + 7;
    
    if (section == 0){
        title = @"This week";
    }
    else if (section == 1){
        title = @"Last week";
    }
    // If the week is in the same month
    else if ([self isSameMonthWithfirstDayOffset:firstDayOffset lastDayOffset:lastDayOffset]){
        NSString *month = [Utilities getDateStringWithoffset:firstDayOffset format:MONTH_FIRST_THREE_LETTERS];
        NSString *firstDay = [Utilities getDateStringWithoffset:firstDayOffset format:DAY_NUMBERS];
        NSString *lastDay = [Utilities getDateStringWithoffset:lastDayOffset format:DAY_NUMBERS];
        title = [NSString stringWithFormat:@"%@ %@ - %@", month, firstDay, lastDay];
    }
    else {
        NSString *firstDay = [Utilities getDateStringWithoffset:firstDayOffset format:MONTH_LETTERS_AND_DAY_NUMBERS];
        NSString *lastDay = [Utilities getDateStringWithoffset:lastDayOffset format:MONTH_LETTERS_AND_DAY_NUMBERS];
        title = [NSString stringWithFormat:@"%@ - %@", firstDay, lastDay];
    }
    
    return title;
}


- (NSString *)getStepsWithsection:(NSInteger)section{
    NSInteger firstDayOffset = firstWeekLength + ((section -1)*7);
    NSInteger lastDayOffset = firstDayOffset + 7;
    
    if (section == 0){
        firstDayOffset = 0;
        lastDayOffset = firstWeekLength;
    }
    
    NSInteger steps = 0;
    while (firstDayOffset < lastDayOffset){
        NSDictionary *day = [daysData objectAtIndex:firstDayOffset];
        NSInteger daySteps = [[day objectForKey:@"steps"]integerValue];
        steps += daySteps;
        firstDayOffset++;
    }
    return [NSString stringWithFormat:@"%ld steps", (long)steps];
}


- (NSInteger)getFirstWeekLength{
    NSInteger offset = 0;
    NSInteger length = 1;
    
    // Checking back until we hit Sunday to determine length of first week
    while ([[[NSCalendar currentCalendar] components: NSCalendarUnitWeekday fromDate: [Utilities getDateByOffset:offset]] weekday] != 1){
        offset--;
        length++;
    }
    return length;
}


- (BOOL)isSameMonthWithfirstDayOffset:(NSInteger)firstDayOffset lastDayOffset:(NSInteger)lastDayOffset{
    NSString *firstMonth = [Utilities getDateStringWithoffset:firstDayOffset format:MONTH_FIRST_THREE_LETTERS];
    NSString *lastMonth = [Utilities getDateStringWithoffset:lastDayOffset format:MONTH_FIRST_THREE_LETTERS];
    
    if ([firstMonth isEqualToString:lastMonth]){
        return YES;
    }else return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"steps_to_graph"]){
        StepsGraphViewController *vc = [segue destinationViewController];
        [vc setData:daysData];
    }
}


- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)unwindToStepsTable:(UIStoryboardSegue *)unwindSegue
{
    [self.tableView reloadData];
}


@end
