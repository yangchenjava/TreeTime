//
//  YCCountDownLabel.h
//  TreeTime
//
//  Created by yangc on 16/12/10.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCCountDownLabel;

@protocol YCCountDownLabelDelegate <NSObject>

@optional
- (void)countDownLabel:(YCCountDownLabel *)countDownLabel timeout:(int)timeout;
- (void)countDownLabelTimeOver:(YCCountDownLabel *)countDownLabel;

@end

IB_DESIGNABLE
@interface YCCountDownLabel : UILabel

@property (nonatomic, weak) id<YCCountDownLabelDelegate> delegate;

@property (nonatomic, assign) IBInspectable int countDownTime;
@property (nonatomic, assign, readonly, getter=isStart) BOOL start;

- (void)start;
- (void)pause;
- (void)stop;

@end
