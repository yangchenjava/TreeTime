//
//  AppDelegate.m
//  TreeTime
//
//  Created by yangc on 16/12/7.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <SDWebImage/SDImageCache.h>
#import <UserNotifications/UserNotifications.h>

#import "AppDelegate.h"
#import "YCNotificationUtils.h"
#import "YCTreeTimeUtils.h"
#import "YCTwitterLaunchUtils.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = YC_Color_RGB(75, 164, 135);
    [_window makeKeyAndVisible];
    [YCTreeTimeUtils setupRootViewController];
    [YCNotificationUtils registerNotificationWithDelegate:self];
    [YCTwitterLaunchUtils setupLaunch];
    return YES;
}

#pragma mark - iOS10收到通知

// App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

// App通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    completionHandler();
}

#pragma mark - iOS10之前收到通知

// 收到本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    YCLog(@"%@", notification.userInfo);
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
