//
//  YCAnalysisBiz.m
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <DateTools/DateTools.h>

#import "YCAnalysisBiz.h"
#import "YCAnalysisResult.h"
#import "YCTreeTimeDao.h"

@implementation YCAnalysisBiz

+ (NSArray *)analysisWithUserId:(long)userId startTime:(NSDate *)startTime endTime:(NSDate *)endTime {
    static NSString * const format = @"yyyy-MM-dd";
    NSDictionary *dict = [YCTreeTimeDao findWithUserId:userId startTime:[startTime formattedDateWithFormat:format] endTime:[endTime formattedDateWithFormat:format]];

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[startTime daysEarlierThan:endTime] + 1];
    while ([startTime isEarlierThanOrEqualTo:endTime]) {
        YCAnalysisResult *result = dict[[startTime formattedDateWithFormat:format]];
        if (!result) {
            result = [[YCAnalysisResult alloc] init];
        }
        result.date = [NSDate dateWithYear:startTime.year month:startTime.month day:startTime.day];
        [array addObject:result];
        startTime = [startTime dateByAddingDays:1];
    }
    return array;
}

@end
