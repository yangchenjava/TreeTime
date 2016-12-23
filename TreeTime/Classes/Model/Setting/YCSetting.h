//
//  YCSetting.h
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface YCSetting : MTLModel

@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *loginPassword;
@property (nonatomic, assign) long userId;

- (YCSetting *)setNil;

@end
