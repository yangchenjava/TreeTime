//
//  YCNavigationController.m
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import "YCNavigationController.h"

@interface YCNavigationController ()

@end

@implementation YCNavigationController

+ (void)initialize {
    [super initialize];
    [self setupNaviTitleStyle];
    [self setupNaviBarButtonItemStyle];
}

/**
 *  @author yangc, 16-06-23 15:06:19
 *
 *  初始化导航标题样式
 */
+ (void)setupNaviTitleStyle {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero; // 去掉阴影
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    // title样式
    naviBar.titleTextAttributes = titleTextAttributes;
    // 背景色
    naviBar.barTintColor = YC_Color_RGB(16, 16, 16);
    // 背景不透明
    // naviBar.translucent = NO;
    // 回退图片颜色
    naviBar.tintColor = [UIColor whiteColor];
}

/**
 *  @author yangc, 16-06-23 15:06:27
 *
 *  初始化导航按钮样式
 */
+ (void)setupNaviBarButtonItemStyle {
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 返回按钮的文字
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

@end
