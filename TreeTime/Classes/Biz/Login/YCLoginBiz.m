//
//  YCLoginBiz.m
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <YCHelpKit/YCHttpUtils.h>

#import "YCLoginBiz.h"
#import "YCRequest.h"
#import "YCResponse.h"
#import "YCLoginParam.h"
#import "YCLoginResult.h"
#import "YCTreeTimeUtils.h"
#import "YCSetting.h"

@implementation YCLoginBiz

+ (void)loginWithParam:(YCLoginParam *)param success:(void (^)(void))success failure:(void (^)(NSString *))failure {
    NSDictionary *params = [[YCRequest requestWithDevID:nil index:101] JSONDictionaryFromModel:param];
    
    [YCHttpUtils sendPost:YC_URL(@"101") params:params success:^(NSHTTPURLResponse *response, id responseObject) {
        YCResponse *resp = [YCResponse responseWithJSONDictionary:responseObject];
        if (resp.status == YCResponseStatusSuccess) {
            YCLoginResult *result = [resp modelOfClass:[YCLoginResult class]];
            
            YCSetting *setting = [YCTreeTimeUtils setting];
            setting.loginName = param.loginName;
            setting.loginPassword = param.loginPassword;
            setting.userId = result.userId;
            [YCTreeTimeUtils setSetting:setting];
            
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

@end
