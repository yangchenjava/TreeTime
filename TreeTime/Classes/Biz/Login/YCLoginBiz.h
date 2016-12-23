//
//  YCLoginBiz.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCLoginParam, YCLoginResult;

@interface YCLoginBiz : NSObject

+ (void)loginWithParam:(YCLoginParam *)param success:(void (^)())success failure:(void (^)(NSString *errorMsg))failure;

@end
