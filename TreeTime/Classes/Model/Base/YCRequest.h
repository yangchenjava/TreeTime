//
//  YCRequest.h
//  TreeTime
//
//  Created by yangc on 16/11/21.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTLJSONSerializing;

@interface YCRequest : NSObject

@property (nonatomic, copy) NSString *devID;
@property (nonatomic, assign) int index;

+ (instancetype)requestWithDevID:(NSString *)devID index:(int)index;
- (instancetype)initWithDevID:(NSString *)devID index:(int)index;

- (NSDictionary *)JSONDictionaryFromObject:(id)object;
- (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model;
- (NSDictionary *)JSONDictionaryFromModels:(NSArray *)models;

@end
