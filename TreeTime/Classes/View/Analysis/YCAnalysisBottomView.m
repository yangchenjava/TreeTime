//
//  YCAnalysisBottomView.m
//  TreeTime
//
//  Created by yangc on 16/12/13.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Charts/Charts-Swift.h>
#import <DateTools/DateTools.h>

#import "YCAnalysisBottomView.h"
#import "YCAnalysisButton.h"
#import "TreeTime-Swift.h"
#import "YCAnalysisBiz.h"
#import "YCTreeTimeUtils.h"
#import "YCSetting.h"
#import "YCAnalysisResult.h"

@interface YCAnalysisBottomView () <ChartViewDelegate, IChartAxisValueFormatter>

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (weak, nonatomic) IBOutlet YCAnalysisButton *btn_health;
@property (weak, nonatomic) IBOutlet YCAnalysisButton *btn_dead;
@property (weak, nonatomic) IBOutlet UILabel *label_date;

- (IBAction)clickPrev;
- (IBAction)clickNext;

@property (nonatomic, strong) NSArray *xAxisLabelArray;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@end

@implementation YCAnalysisBottomView

- (NSArray *)xAxisLabelArray {
    if (_xAxisLabelArray == nil) {
        _xAxisLabelArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    }
    return _xAxisLabelArray;
}

+ (instancetype)bottomViewWithFrame:(CGRect)frame {
    YCAnalysisBottomView *view = [[NSBundle mainBundle] loadNibNamed:@"YCAnalysisBottomView" owner:nil options:nil].lastObject;
    view.frame = frame;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupChartView];
}

- (void)setupChartView {
    _chartView.delegate = self;
    _chartView.backgroundColor = [UIColor clearColor];
    _chartView.noDataText = @"暂无数据";
    _chartView.chartDescription.enabled = NO;
    _chartView.legend.enabled = NO;
    _chartView.dragEnabled = NO;
    [_chartView setScaleEnabled:NO];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.valueFormatter = self;
    xAxis.labelTextColor = YC_Color_RGBA(124, 124, 124, 0.8);
    xAxis.labelFont = [UIFont systemFontOfSize:14];
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = 8;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.axisMinimum = 0;
    leftAxis.drawLabelsEnabled = NO;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.drawGridLinesEnabled = NO;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.axisMinimum = 0;
    rightAxis.drawLabelsEnabled = NO;
    rightAxis.drawAxisLineEnabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
}

- (void)setupInitData {
    NSDate *now = [NSDate date];
    _startTime = [now dateBySubtractingDays:now.weekday - 1];
    _endTime = [now dateByAddingDays:7 - now.weekday];
    self.array = [YCAnalysisBiz analysisWithUserId:[YCTreeTimeUtils setting].userId startTime:_startTime endTime:_endTime];
    
    for (int i = 0; i < _array.count; i++) {
        YCAnalysisResult *result = _array[i];
        if (result.date.isToday) {
            [_chartView highlightValueWithX:i + 1 dataSetIndex:0 callDelegate:YES];
            break;
        }
    }
}

- (IBAction)clickPrev {
    _startTime = [_startTime dateBySubtractingWeeks:1];
    _endTime = [_endTime dateBySubtractingWeeks:1];
    self.array = [YCAnalysisBiz analysisWithUserId:[YCTreeTimeUtils setting].userId startTime:_startTime endTime:_endTime];
    [_chartView highlightValueWithX:self.array.count dataSetIndex:0 callDelegate:YES];
}

- (IBAction)clickNext {
    _startTime = [_startTime dateByAddingWeeks:1];
    _endTime = [_endTime dateByAddingWeeks:1];
    self.array = [YCAnalysisBiz analysisWithUserId:[YCTreeTimeUtils setting].userId startTime:_startTime endTime:_endTime];
    [_chartView highlightValueWithX:1 dataSetIndex:0 callDelegate:YES];
}

- (void)setArray:(NSArray *)array {
    _array = array;
    
    int green = 0, yellow = 0;
    NSMutableArray *entryArray = [[NSMutableArray alloc] initWithCapacity:_array.count];
    for (int i = 0; i < _array.count; i++) {
        YCAnalysisResult *result = _array[i];
        green += result.green;
        yellow += result.yellow;
        [entryArray addObject:[[BarChartDataEntry alloc] initWithX:i + 1 y:result.green + result.yellow]];
    }
    
    [_btn_health setTitle:[NSString stringWithFormat:@"%d", green] forState:UIControlStateNormal];
    [_btn_dead setTitle:[NSString stringWithFormat:@"%d", yellow] forState:UIControlStateNormal];
    _label_date.text = [NSString stringWithFormat:@"%ld %ld月%ld-%ld月%ld", _startTime.year, _startTime.month, _startTime.day, _endTime.month, _endTime.day];
    
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithValues:entryArray];
    [dataSet setColor:YC_Color_RGB(131, 182, 64)];
    [dataSet setHighlightColor:YC_Color_RGB(208, 220, 158)];
    dataSet.drawValuesEnabled = NO;
    dataSet.highlightEnabled = YES;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:dataSet];
    data.barWidth = 0.65;
    [_chartView animateWithYAxisDuration:1];
    if (data.yMax) {
        _chartView.leftAxis.axisMaximum = data.yMax;
    }
    _chartView.data = data;
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
    if ([self.delegate respondsToSelector:@selector(analysisBottomView:didSelectChartValue:)]) {
        YCAnalysisResult *result = _array[(int) entry.x - 1];
        [self.delegate analysisBottomView:self didSelectChartValue:result];
    }
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    if (value > 0 && value < 8) {
        return self.xAxisLabelArray[(int) value - 1];
    }
    return nil;
}

@end
