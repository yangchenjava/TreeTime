//
//  YCRequest.m
//  TreeTime
//
//  Created by yangc on 16/11/21.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Mantle/Mantle.h>

#import "YCRequest.h"

@implementation YCRequest

+ (instancetype)requestWithDevID:(NSString *)devID index:(int)index {
    return [[self alloc] initWithDevID:devID index:index];
}

- (instancetype)initWithDevID:(NSString *)devID index:(int)index {
    if (self = [super init]) {
        self.devID = devID;
        self.index = index;
    }
    return self;
}

- (NSDictionary *)JSONDictionaryFromObject:(id)object {
    return @{@"devID": (self.devID.length ? self.devID : [NSNull null]), @"index": @(self.index), @"reqParams": (object ? object : [NSNull null])};
}

- (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model {
    NSDictionary *reqParams = [MTLJSONAdapter JSONDictionaryFromModel:model error:NULL];
    return @{@"devID": (self.devID.length ? self.devID : [NSNull null]), @"index": @(self.index), @"reqParams": reqParams};
}

- (NSDictionary *)JSONDictionaryFromModels:(NSArray *)models {
    NSArray *reqParams = [MTLJSONAdapter JSONArrayFromModels:models error:NULL];
    return @{@"devID": (self.devID.length ? self.devID : [NSNull null]), @"index": @(self.index), @"reqParams": reqParams};
}

@end
