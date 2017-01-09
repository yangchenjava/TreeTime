//
//  YCMainBackgroundImageView.m
//  TreeTime
//
//  Created by yangc on 16/12/18.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCMainBackgroundImageView.h"

@implementation YCMainBackgroundImageView

- (void)setupImageWithLive {
    self.image = [UIImage imageNamed:@"tree_background"];
}

- (void)setupImageWithDead {
    self.image = [UIImage imageNamed:@"tree_background_dead"];
}

@end
