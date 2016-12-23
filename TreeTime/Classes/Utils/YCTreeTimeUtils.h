//
//  YCTreeTimeUtils.h
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCSetting;

@interface YCTreeTimeUtils : NSObject

+ (YCSetting *)setting;
+ (void)setSetting:(YCSetting *)setting;

+ (void)setupRootViewController;
+ (void)setupRootViewControllerWithMain;

@end
