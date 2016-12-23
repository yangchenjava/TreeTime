//
//  YCRankResult.h
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YCRankResult : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int number;

@end
