//
//  YCRankBiz.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCRankParam;

@interface YCRankBiz : NSObject

+ (void)rankWithParam:(YCRankParam *)param success:(void (^)(NSArray *array))success failure:(void (^)(NSString *errorMsg))failure;

@end
