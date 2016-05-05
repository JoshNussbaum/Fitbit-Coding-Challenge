//
//  StepsGraphViewController.m
//  CodingChallenge
//
//  Created by Josh Nussbaum on 11/17/15.
//  Copyright (c) 2015 Josh Nussbaum. All rights reserved.
//

#import "StepsGraphViewController.h"
#import "Utilities.h"
#import "StepsTableViewController.h"

@interface StepsGraphViewController (){
    NSMutableArray *daysData;
    CPTBarPlot* plot;
    CPTXYPlotSpace *plotSpace;
    BOOL firstLoad;
    BOOL addingData;
}

@end

@implementation StepsGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstLoad = YES;
    addingData = NO;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}


- (void)configureGraph{
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    graph.plotAreaFrame.masksToBorder = NO;
    self.graphView.hostedGraph = graph;
    plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.delegate = self;
    plotSpace.allowsMomentum = YES;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:0] length:[NSNumber numberWithInteger:10000]];
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:0] length:[NSNumber numberWithInteger:daysData.count + 2]];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:(daysData.count - 4)] length:[NSNumber numberWithInteger:5]];
}


- (void)configurePlots{
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor lightGrayColor];
    barLineStyle.lineWidth = 0.5;
    
    plot = [[CPTBarPlot alloc]initWithFrame:CGRectZero];
    plot.plotArea.masksToBorder = YES;
    plot.dataSource = self;
    plot.delegate = self;
    plot.lineStyle = barLineStyle;
    
    CPTGraph *graph = self.graphView.hostedGraph;
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
}


- (void)configureAxes{
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.graphView.hostedGraph.axisSet;
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];

    NSMutableArray *customXLabels = [NSMutableArray array];
    int location = 0;
    for (NSInteger i = (daysData.count); i >= 0; i--){
        NSString *day = [Utilities getDateStringWithoffset:i format:DAY_FIRST_THREE_LETTERS];
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:day textStyle:axisSet.xAxis.labelTextStyle];
        newLabel.tickLocation = [NSNumber numberWithInteger:location];
        newLabel.offset = axisSet.xAxis.labelOffset + axisSet.xAxis.majorTickLength;
        [customXLabels addObject:newLabel];
        location++;
    }
    axisSet.xAxis.axisLabels = [NSSet setWithArray:customXLabels];
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.yAxis.hidden = YES;
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
}


- (void)setData:(NSMutableArray *)data{
    daysData = [[NSMutableArray alloc]init];
    daysData = [[[data reverseObjectEnumerator] allObjects]mutableCopy];
}


#pragma mark - CPTPlotDataSource methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return daysData.count;
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    NSInteger x = index + 1;
    
    NSInteger steps = [[daysData[index] objectForKey:@"steps"] integerValue];
    NSNumber *y = [NSNumber numberWithInteger:steps];
    
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX:
            return [NSNumber numberWithInteger:x];
            break;
        case CPTScatterPlotFieldY:
            return y;
            break;
            
        default:
            break;
    }
    
    return nil;
}


-(CGPoint)plotSpace:(CPTPlotSpace *)space willDisplaceBy:(CGPoint)displacement {
    return CGPointMake(displacement.x, 0);
}



-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate{
    NSInteger x = [newRange.location integerValue];
    if (x < 1 && firstLoad){
        firstLoad = NO;
    }
    else if (x < 1){
        if (addingData){
            newRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:(numberOfDays-1)] length:[NSNumber numberWithInteger:5]];
        }
        else{
            addingData = YES;
            [self addMoreData];
            plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:0] length:[NSNumber numberWithInteger:daysData.count + 2]];
            [plot reloadData];
            newRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInteger:numberOfDays] length:[NSNumber numberWithInteger:5]];
            [self configureAxes];
        }
    }
    else if (x > 2){
        addingData = NO;
    }
    return newRange;
}


- (void)addMoreData{
    daysData = [[[daysData reverseObjectEnumerator] allObjects]mutableCopy];
    [Utilities makeFakeData:daysData];
    daysData = [[[daysData reverseObjectEnumerator] allObjects]mutableCopy];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"graph_to_steps"]){
        StepsTableViewController *vc = [segue destinationViewController];
        daysData = [[[daysData reverseObjectEnumerator] allObjects]mutableCopy];
        [vc setData:daysData];
    }
}

@end
