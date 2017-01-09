//
//  YCAnalysisResult.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCAnalysisResult : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) int green;
@property (nonatomic, assign) int yellow;
@property (nonatomic, assign) int score;

@end
