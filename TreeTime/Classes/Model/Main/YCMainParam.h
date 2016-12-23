//
//  YCMainParam.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM(NSUInteger, YCMainStatus) {
    YCMainStatusStart = 0,
    YCMainStatusSuccess = 1,
    YCMainStatusFailure = 2
};

@interface YCMainParam : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) long ID;
@property (nonatomic, assign) int score;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) YCMainStatus status;
@property (nonatomic, assign) long userId;
@property (nonatomic, assign, getter=isSync) BOOL sync;

@end
