//
//  YCAnalysisBottomView.h
//  TreeTime
//
//  Created by yangc on 16/12/13.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCAnalysisBottomView, YCAnalysisResult;

@protocol YCAnalysisBottomViewDelegate <NSObject>

@optional
- (void)analysisBottomView:(YCAnalysisBottomView *)analysisBottomView didSelectChartValue:(YCAnalysisResult *)chartValue;

@end

@interface YCAnalysisBottomView : UIView

@property (nonatomic, weak) id<YCAnalysisBottomViewDelegate> delegate;

+ (instancetype)bottomViewWithFrame:(CGRect)frame;

- (void)setupInitData;

@end
