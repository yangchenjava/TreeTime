//
//  YCTwitterLaunchUtils.m
//  TreeTime
//
//  Created by yangc on 16/12/16.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCTwitterLaunchUtils.h"

@implementation YCTwitterLaunchUtils

+ (void)setupLaunch {
    UIView *rootView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = rootView.center;
    layer.contents = (id) [UIImage imageNamed:@"login_logo"].CGImage;
    rootView.layer.mask = layer;
    
    UIView *shelterView = [[UIView alloc] initWithFrame:rootView.frame];
    shelterView.backgroundColor = [UIColor whiteColor];
    [rootView addSubview:shelterView];
    
    CAKeyframeAnimation *logoAnim = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoAnim.beginTime = CACurrentMediaTime() + 0.5;
    logoAnim.duration = 1;
    logoAnim.removedOnCompletion = NO;
    logoAnim.fillMode = kCAFillModeForwards;
    logoAnim.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    logoAnim.keyTimes = @[@0, @0.4, @1];
    logoAnim.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)], [NSValue valueWithCGRect:CGRectMake(0, 0, 70, 70)], [NSValue valueWithCGRect:CGRectMake(0, 0, 4500, 4500)]];
    [layer addAnimation:logoAnim forKey:nil];
    
    CAKeyframeAnimation *contentAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    contentAnim.beginTime = CACurrentMediaTime() + 0.6;
    contentAnim.duration = 0.5;
    contentAnim.keyTimes = @[@0, @0.5, @1];
    contentAnim.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [rootView.layer addAnimation:contentAnim forKey:nil];
    //    rootView.layer.transform = CATransform3DIdentity;
    
    [UIView animateWithDuration:0.3 delay:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        shelterView.alpha = 0;
    } completion:^(BOOL finished) {
        [shelterView removeFromSuperview];
        rootView.layer.mask = nil;
    }];
}

@end
