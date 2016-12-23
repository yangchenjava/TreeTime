//
//  YCMainBiz.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YCMainParam.h"

@interface YCMainBiz : NSObject

+ (void)mainWithParam:(YCMainParam *)param success:(void (^)())success failure:(void (^)(NSString *errorMsg))failure;

+ (void)mainInsertWithParam:(YCMainParam *)param;

+ (void)mainUpdateWithID:(long)ID status:(YCMainStatus)status;

+ (void)mainUpdateWithID:(long)ID sync:(BOOL)sync;

+ (YCMainParam *)mainLastWithUserId:(long)userId;

+ (NSArray *)mainNotSyncWithUserId:(long)userId;

@end
