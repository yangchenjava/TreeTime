//
//  YCAnalysisTopView.h
//  TreeTime
//
//  Created by yangc on 16/12/13.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YCAnalysisBottomView.h"

@interface YCAnalysisTopView : UIView <YCAnalysisBottomViewDelegate>

+ (instancetype)topViewWithFrame:(CGRect)frame;

@end
