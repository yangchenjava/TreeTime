//
//  YCNotificationUtils.h
//  TreeTime
//
//  Created by yangc on 16/12/16.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface YCNotificationUtils : NSObject

+ (void)registerNotificationWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate;

+ (void)addLocalNotificationWithTitle:(NSString *)title body:(NSString *)body soundName:(NSString *)soundName timeInterval:(NSTimeInterval)timeInterval;

+ (void)removeAllNotification;

+ (void)playNotificationSound:(NSString *)soundName;

@end
