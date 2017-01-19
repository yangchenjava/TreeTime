//
//  YCMainTreeImageView.m
//  TreeTime
//
//  Created by yangc on 16/12/12.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCMainTreeImageView.h"
#import "YCGlobalConst.h"

@implementation YCMainTreeImageView

- (void)setupImageWithProgress:(CGFloat)progress {
    if (progress < 1 / YC_Main_Multi) {
        self.image = [UIImage imageNamed:@"default_5"];
    } else if (progress < 2 / YC_Main_Multi) {
        self.image = [UIImage imageNamed:@"default_6"];
    } else if (progress < 3 / YC_Main_Multi) {
        self.image = [UIImage imageNamed:@"default_7"];
    } else if (progress < 4 / YC_Main_Multi) {
        self.image = [UIImage imageNamed:@"default_8"];
    } else {
        self.image = [UIImage imageNamed:@"default_9"];
    }
}

- (void)setupImageWithTime:(int)time {
    if (time < YC_Main_Init_Second / YC_Main_Multi * 1) {
        self.image = [UIImage imageNamed:@"default_1"];
    } else if (time < YC_Main_Init_Second / YC_Main_Multi * 2) {
        self.image = [UIImage imageNamed:@"default_2"];
    } else if (time < YC_Main_Init_Second / YC_Main_Multi * 3) {
        self.image = [UIImage imageNamed:@"default_3"];
    } else if (time < YC_Main_Init_Second / YC_Main_Multi * 4) {
        self.image = [UIImage imageNamed:@"default_4"];
    } else if (time < YC_Main_Init_Second + YC_Main_Grow_Second / YC_Main_Multi * 1) {
        self.image = [UIImage imageNamed:@"default_5"];
    } else if (time < YC_Main_Init_Second + YC_Main_Grow_Second / YC_Main_Multi * 2) {
        self.image = [UIImage imageNamed:@"default_6"];
    } else if (time < YC_Main_Init_Second + YC_Main_Grow_Second / YC_Main_Multi * 3) {
        self.image = [UIImage imageNamed:@"default_7"];
    } else if (time < YC_Main_Init_Second + YC_Main_Grow_Second / YC_Main_Multi * 4) {
        self.image = [UIImage imageNamed:@"default_8"];
    } else {
        self.image = [UIImage imageNamed:@"default_9"];
    }
}

- (void)setupImageWithDead {
    self.image = [UIImage imageNamed:@"default_dead"];
}

@end
