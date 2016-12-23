//
//  YCResponse.h
//  TreeTime
//
//  Created by yangc on 16/11/21.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YCResponseStatus) {
    YCResponseStatusSuccess = 0,
    YCResponseStatusTokenTimeout = 103
};

@interface YCResponse : NSObject

@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id resp;

+ (instancetype)responseWithJSONDictionary:(NSDictionary *)JSONDictionary;
- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary;

- (id)modelOfClass:(Class)modelClass;
- (NSArray *)modelsOfClass:(Class)modelClass;

@end
