//
//  YCMainTreeImageView.h
//  TreeTime
//
//  Created by yangc on 16/12/12.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCMainTreeImageView : UIImageView

- (void)setupImageWithProgress:(CGFloat)progress;
- (void)setupImageWithTime:(int)time;
- (void)setupImageWithDead;

@end
