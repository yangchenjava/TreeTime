//
//  YCTreeTimeDao.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YCMainParam.h"

@interface YCTreeTimeDao : NSObject

+ (void)insertWithParam:(YCMainParam *)param;

+ (void)updateWithID:(long)ID status:(YCMainStatus)status;

+ (void)updateWithID:(long)ID sync:(BOOL)sync;

+ (YCMainParam *)findLastWithUserId:(long)userId;

+ (NSArray *)findNotSyncWithUserId:(long)userId;

+ (NSDictionary *)findWithUserId:(long)userId startTime:(NSString *)startTime endTime:(NSString *)endTime;

@end
