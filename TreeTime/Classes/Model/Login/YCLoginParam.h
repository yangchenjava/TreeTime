//
//  YCLoginParam.h
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YCLoginParam : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *loginPassword;

@end
