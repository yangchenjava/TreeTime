//
//  YCSetting.m
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCSetting.h"

@implementation YCSetting

- (YCSetting *)setNil {
    _loginName = nil;
    _loginPassword = nil;
    _userId = 0;
    return self;
}

@end
