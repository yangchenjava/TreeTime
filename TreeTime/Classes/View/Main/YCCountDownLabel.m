//
//  YCCountDownLabel.m
//  TreeTime
//
//  Created by yangc on 16/12/10.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCCountDownLabel.h"

static YCCountDownLabel *_this;

@interface YCCountDownLabel () {
    // dispatch_source_t _timer;
    NSTimer *_timer;
}

@property (nonatomic, assign) int timeout;
@property (nonatomic, assign) NSTimeInterval lockedTime;

@end

@implementation YCCountDownLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    _this = self;
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, YCNotificationOff, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, YCNotificationOn, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

- (void)dealloc {
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL);
    [_timer invalidate];
    _timer = nil;
}

static void screenLockStateChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSString *lockstate = (__bridge NSString *) name;
    if ([lockstate isEqualToString:(__bridge NSString *) YCNotificationOff]) {
        if (_this.isStart) {
            [_this pause];
            _this.lockedTime = [NSDate date].timeIntervalSince1970;
        }
    } else {
        if (_this.lockedTime) {
            _this.timeout -= [NSDate date].timeIntervalSince1970 - _this.lockedTime;
            [_this start];
            _this.lockedTime = 0;
        }
    }
}

- (NSString *)formatSecond:(int)second {
    if (second < 0) second = 0;
    int h = second / 3600;
    int m = (second - h * 3600) / 60;
    int s = second % 60;
    if (h) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
    } else {
        return [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
}

- (void)setCountDownTime:(int)countDownTime {
    if (_start) {
        [self stop];
    }
    if (countDownTime < 0) {
        countDownTime = 0;
    }
    _countDownTime = countDownTime;
    self.text = [self formatSecond:_countDownTime];
    _timeout = _countDownTime;
}

- (void)start {
    if (!_timer) {
        @synchronized (_timer) {
            if (!_timer) {
                /*
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
                dispatch_source_set_event_handler(_timer, ^{
                    if (_timeout <= 0) {
                        [self stop];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.text = [self formatSecond:_timeout];
                            if ([self.delegate respondsToSelector:@selector(countDownLabelTimeOver:)]) {
                                [self.delegate countDownLabelTimeOver:self];
                            }
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.text = [self formatSecond:_timeout];
                            if ([self.delegate respondsToSelector:@selector(countDownLabel:timeout:)]) {
                                [self.delegate countDownLabel:self timeout:_timeout];
                            }
                        });
                        _timeout--;
                    }
                });
                dispatch_resume(_timer);
                _start = YES;
                 */
                [self countDown];
                _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                _start = YES;
            }
        }
    }
}

- (void)countDown {
    if (_timeout <= 0) {
        [self stop];
        self.text = [self formatSecond:_timeout];
        if ([self.delegate respondsToSelector:@selector(countDownLabelTimeOver:)]) {
            [self.delegate countDownLabelTimeOver:self];
        }
    } else {
        self.text = [self formatSecond:_timeout];
        if ([self.delegate respondsToSelector:@selector(countDownLabel:timeout:)]) {
            [self.delegate countDownLabel:self timeout:_timeout];
        }
        _timeout--;
    }
}

- (void)pause {
    if (_timer) {
        @synchronized (_timer) {
            if (_timer) {
                // dispatch_source_cancel(_timer);
                // _timer = NULL;
                [_timer invalidate];
                _timer = nil;
                _start = NO;
            }
        }
    }
}

- (void)stop {
    if (_timer) {
        @synchronized (_timer) {
            if (_timer) {
                // dispatch_source_cancel(_timer);
                // _timer = NULL;
                [_timer invalidate];
                _timer = nil;
                _timeout = 0;
                _start = NO;
            }
        }
    }
}

@end
