//
//  YCAnalysisBiz.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCAnalysisBiz : NSObject

+ (NSArray *)analysisWithUserId:(long)userId startTime:(NSDate *)startTime endTime:(NSDate *)endTime;

@end
