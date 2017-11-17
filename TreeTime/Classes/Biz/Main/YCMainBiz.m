//
//  YCMainBiz.m
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <YCHelpKit/YCHttpUtils.h>

#import "YCMainBiz.h"
#import "YCRequest.h"
#import "YCResponse.h"
#import "YCTreeTimeDao.h"

@implementation YCMainBiz

+ (void)mainWithParam:(YCMainParam *)param success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure {
    NSDictionary *params = [[YCRequest requestWithDevID:nil index:102] JSONDictionaryFromModel:param];
    
    [YCHttpUtils sendPost:YC_URL(@"102") params:params success:^(NSHTTPURLResponse *response, id responseObject) {
        YCResponse *resp = [YCResponse responseWithJSONDictionary:responseObject];
        if (resp.status == YCResponseStatusSuccess) {
            if (success) {
                success();
            }
        } else {
            if (failure) {
                failure(resp.msg);
            }
        }
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        YCLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)mainInsertWithParam:(YCMainParam *)param {
    [YCTreeTimeDao insertWithParam:param];
}

+ (void)mainUpdateWithID:(long)ID status:(YCMainStatus)status {
    [YCTreeTimeDao updateWithID:ID status:status];
}

+ (void)mainUpdateWithID:(long)ID sync:(BOOL)sync {
    [YCTreeTimeDao updateWithID:ID sync:sync];
}

+ (YCMainParam *)mainLastWithUserId:(long)userId {
    return [YCTreeTimeDao findLastWithUserId:userId];
}

+ (NSArray *)mainNotSyncWithUserId:(long)userId {
    return [YCTreeTimeDao findNotSyncWithUserId:userId];
}

@end
