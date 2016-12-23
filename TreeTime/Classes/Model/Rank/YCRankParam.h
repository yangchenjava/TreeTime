//
//  YCRankParam.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YCRankParam : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) long userId;
@property (nonatomic, strong) NSArray *data;

@end
