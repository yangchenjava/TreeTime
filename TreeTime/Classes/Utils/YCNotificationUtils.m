//
//  YCNotificationUtils.m
//  TreeTime
//
//  Created by yangc on 16/12/16.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "YCNotificationUtils.h"

@implementation YCNotificationUtils

+ (void)registerNotificationWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate {
    if (iOS10_OR_Later) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = delegate;
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted && !error) {
                YCLog(@"通知注册成功");
            } else {
                YCLog(@"通知注册失败");
            }
        }];
        // 之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在apple开放了这个API，我们可以直接获取到用户的设定信息
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            YCLog(@"%@", settings);
        }];
    } else if (iOS8_OR_Later) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

+ (void)addLocalNotificationWithTitle:(NSString *)title body:(NSString *)body soundName:(NSString *)soundName timeInterval:(NSTimeInterval)timeInterval {
    if (iOS10_OR_Later) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = title;
        content.body = body;
        // content.sound = [UNNotificationSound defaultSound];
        content.sound = [UNNotificationSound soundNamed:soundName];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NSBundle mainBundle].bundleIdentifier content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO]];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    } else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertTitle = title;
        notification.alertBody = body;
        // notification.soundName = UILocalNotificationDefaultSoundName;
        notification.soundName = soundName;
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

+ (void)removeAllNotification {
    if (iOS10_OR_Later) {
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

static void audioServicesSystemSoundCompletion(SystemSoundID soundID, void *clientData) {
    AudioServicesDisposeSystemSoundID(soundID);
}

+ (void)playNotificationSound:(NSString *)soundName {
    // 三全音
    // AudioServicesPlaySystemSound(1007);
    // 震动
    // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
    SystemSoundID soundID;
    if (AudioServicesCreateSystemSoundID((__bridge CFURLRef) url, &soundID)) {
        YCLog(@"AudioServicesCreateSystemSoundID - Error");
    } else {
        AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, audioServicesSystemSoundCompletion, NULL);
        AudioServicesPlaySystemSound(soundID);
    }
}

@end
