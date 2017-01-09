//
//  YCResponse.m
//  TreeTime
//
//  Created by yangc on 16/11/21.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "YCResponse.h"

@implementation YCResponse

+ (instancetype)responseWithJSONDictionary:(NSDictionary *)JSONDictionary {
    return [[self alloc] initWithJSONDictionary:JSONDictionary];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary {
    if (self = [super init]) {
        self.status = [JSONDictionary[@"status"] intValue];
        self.msg = JSONDictionary[@"msg"];
        self.resp = JSONDictionary[@"resp"];
    }
    return self;
}

- (id)modelOfClass:(Class)modelClass {
    return [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:self.resp error:NULL];
}

- (NSArray *)modelsOfClass:(Class)modelClass {
    return [MTLJSONAdapter modelsOfClass:modelClass fromJSONArray:self.resp error:NULL];
}

@end
