//
//  YCTreeTimeUtils.m
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCTreeTimeUtils.h"
#import "YCSetting.h"
#import "YCNavigationController.h"
#import "YCLoginViewController.h"
#import "YCMainViewController.h"

@implementation YCTreeTimeUtils

+ (YCSetting *)setting {
    static NSString *settingPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingPath = [YC_Dir_Document stringByAppendingPathComponent:@"Setting.data"];
    });
    YCSetting *setting = [NSKeyedUnarchiver unarchiveObjectWithFile:settingPath];
    if (setting == nil) {
        setting = [[YCSetting alloc] init];
    }
    return setting;
}

+ (void)setSetting:(YCSetting *)setting {
    static NSString *settingPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingPath = [YC_Dir_Document stringByAppendingPathComponent:@"Setting.data"];
    });
    if (setting == nil) {
        setting = [self setting].setNil;
    }
    [NSKeyedArchiver archiveRootObject:setting toFile:settingPath];
}

+ (void)setupRootViewController {
    YCSetting *setting = [self setting];
    if (setting.loginName.length && setting.loginPassword.length) {
        [self setupRootViewControllerWithMain];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[YCLoginViewController alloc] init];
    }
}

+ (void)setupRootViewControllerWithMain {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[YCNavigationController alloc] initWithRootViewController:[[YCMainViewController alloc] init]];
}

@end
