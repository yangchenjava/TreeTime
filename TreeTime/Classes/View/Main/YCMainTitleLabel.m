//
//  YCMainTitleLabel.m
//  TreeTime
//
//  Created by yangc on 16/12/12.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCMainTitleLabel.h"

@interface YCMainTitleLabel ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation YCMainTitleLabel

- (NSArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = @[@"现在就放下手机吧！", @"不要再滑手机了", @"赶快去做事", @"不要一直看我，人家会害羞", @"专注！专注！", @"加油，你做的到的！", @"放下手机，认真生活", @"一分一秒，皆是您专注的时光", @"种一棵树，心无旁骛", @"加油，时间快到了"];
    }
    return _titleArray;
}

- (void)setupInitText {
    self.text = @"开始种树吧！";
}

- (void)setupSuccessText {
    self.text = @"恭喜，您种植了健康的树";
}

- (void)setupFailureText {
    self.text = @"这次失败了，下次再努力吧！";
}

- (void)setupRandomText {
    self.text = self.titleArray[arc4random_uniform((int) self.titleArray.count)];
}

@end
