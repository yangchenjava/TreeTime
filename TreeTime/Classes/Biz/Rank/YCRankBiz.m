//
//  YCRankBiz.m
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <YCHelpKit/YCHttpUtils.h>

#import "YCRankBiz.h"
#import "YCRequest.h"
#import "YCResponse.h"
#import "YCRankParam.h"
#import "YCRankResult.h"

@implementation YCRankBiz

+ (void)rankWithParam:(YCRankParam *)param success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure {
    NSDictionary *params = [[YCRequest requestWithDevID:nil index:103] JSONDictionaryFromModel:param];
    
    [YCHttpUtils sendPost:YC_URL(@"103") params:params success:^(NSHTTPURLResponse *response, id responseObject) {
        YCResponse *resp = [YCResponse responseWithJSONDictionary:responseObject];
        if (resp.status == YCResponseStatusSuccess) {
            if (success) {
                success([resp modelsOfClass:[YCRankResult class]]);
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

@end
