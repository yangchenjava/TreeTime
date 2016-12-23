//
//  YCAnalysisTopView.m
//  TreeTime
//
//  Created by yangc on 16/12/13.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <DateTools/DateTools.h>
#import <YCHelpKit/UIView+Category.h>

#import "YCAnalysisTopView.h"
#import "YCAnalysisButton.h"
#import "YCAnalysisResult.h"
#import "YCGlobalConst.h"

@interface YCAnalysisTopView ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) YCAnalysisButton *btn_health;
@property (nonatomic, weak) YCAnalysisButton *btn_dead;
@property (nonatomic, weak) UIImageView *image_bg;
@property (nonatomic, weak) UILabel *label_score;

@property (nonatomic, strong) YCAnalysisResult *result;
@property (nonatomic, strong) NSArray *dynamicArray;

@end

@implementation YCAnalysisTopView

+ (instancetype)topViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat label_W = YC_ScreenWidth * 0.5;
        CGFloat label_H = 30.0;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(YC_Analysis_Margin, YC_Base_Margin + 5, label_W, label_H)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:23];
        [self addSubview:label];
        _label = label;
        
        CGFloat btn_W = (YC_ScreenWidth - CGRectGetMaxX(_label.frame) - YC_Analysis_Margin) * 0.5;
        CGFloat btn_H = label_H;
        YCAnalysisButton *btn_health = [YCAnalysisButton buttonWithType:UIButtonTypeCustom];
        btn_health.frame = CGRectMake(CGRectGetMaxX(_label.frame), CGRectGetMinY(_label.frame), btn_W, btn_H);
        btn_health.userInteractionEnabled = NO;
        btn_health.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn_health setImage:[UIImage imageNamed:@"tree_icon_healthy"] forState:UIControlStateNormal];
        [self addSubview:btn_health];
        _btn_health = btn_health;
        
        YCAnalysisButton *btn_dead = [YCAnalysisButton buttonWithType:UIButtonTypeCustom];
        btn_dead.frame = CGRectMake(CGRectGetMaxX(_btn_health.frame), CGRectGetMinY(_btn_health.frame), btn_W, btn_H);
        btn_dead.userInteractionEnabled = NO;
        btn_dead.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn_dead setImage:[UIImage imageNamed:@"tree_icon_dead"] forState:UIControlStateNormal];
        [self addSubview:btn_dead];
        _btn_dead = btn_dead;
        
        CGFloat image_X = YC_Analysis_Margin;
        CGFloat image_Y = CGRectGetMaxY(_label.frame) + YC_Base_Margin;
        CGFloat image_W = YC_ScreenWidth - 2 * YC_Analysis_Margin;
        CGFloat image_H = frame.size.height - image_Y - YC_Base_Margin;
        UIImageView *image_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground"]];
        image_bg.frame = CGRectMake(image_X, image_Y, image_W, image_H);
        image_bg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image_bg];
        _image_bg = image_bg;
        
        CGFloat label_score_W = 100.0;
        UILabel *label_score = [[UILabel alloc] initWithFrame:CGRectMake(YC_ScreenWidth - YC_Analysis_Margin - label_score_W, image_Y, label_score_W, 20.0)];
        label_score.textAlignment = NSTextAlignmentRight;
        label_score.textColor = [UIColor whiteColor];
        label_score.font = [UIFont systemFontOfSize:16];
        [self addSubview:label_score];
        _label_score = label_score;
    }
    return self;
}

- (NSArray *)dynamicArray {
    if (_dynamicArray == nil) {
        NSMutableArray *dynamicArray = [NSMutableArray arrayWithCapacity:25];
        for (int i = 0; i < YC_Analysis_Max_Block; i++) {
            [dynamicArray addObject:[[UIDynamicAnimator alloc] initWithReferenceView:_image_bg]];
        }
        _dynamicArray = dynamicArray;
    }
    return _dynamicArray;
}

- (void)analysisBottomView:(YCAnalysisBottomView *)analysisBottomView didSelectChartValue:(YCAnalysisResult *)chartValue {
    if (_result == chartValue) {
        return;
    }
    _result = chartValue;
    
    if (_result.date.isYesterday) {
        _label.text = @"昨天";
    } else if (_result.date.isToday) {
        _label.text = @"今天";
    } else if (_result.date.isTomorrow) {
        _label.text = @"明天";
    } else {
        _label.text = [NSString stringWithFormat:@"%ld月%ld", _result.date.month, _result.date.day];
    }
    [_btn_health setTitle:[NSString stringWithFormat:@"%d", _result.green] forState:UIControlStateNormal];
    [_btn_dead setTitle:[NSString stringWithFormat:@"%d", _result.yellow] forState:UIControlStateNormal];
    _label_score.text = [NSString stringWithFormat:@"%d分钟", _result.score / 60];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ((_result.green + _result.yellow) >= 15) {
        for (int i = 0; i < _result.green; i++) {
            [dict setObject:@"forest_default" forKey:@(i)];
        }
        for (int i = 0; i < _result.yellow; i++) {
            [dict setObject:@"forest_default_dead" forKey:@(i + _result.green)];
        }
    } else {
        while (_result.green != dict.count) {
            NSNumber *key = @(arc4random_uniform(YC_Analysis_Max_Block));
            if ([dict objectForKey:key]) {
                continue;
            } else {
                [dict setObject:@"forest_default" forKey:key];
            }
        }
        while (_result.yellow != (dict.count - _result.green)) {
            NSNumber *key = @(arc4random_uniform(YC_Analysis_Max_Block));
            if ([dict objectForKey:key]) {
                continue;
            } else {
                [dict setObject:@"forest_default_dead" forKey:key];
            }
        }
    }
    
    [_image_bg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.dynamicArray makeObjectsPerformSelector:@selector(removeAllBehaviors)];
    for (int i = 0; i < YC_Analysis_Max_Block; i++) {
        NSString *imageName = dict[@(i)];
        if (imageName.length) {
            // 偏移量
            int x, y;
            if (YC_iPhone5SE) {
                x = -28 * (i % 5 - i / 5);
                y = -14 * (6 - i % 5 - i / 5);
            } else if (YC_iPhone6) {
                x = -33 * (i % 5 - i / 5);
                y = -15 * (6 - i % 5 - i / 5);
            } else if (YC_iPhone6Plus) {
                x = -38 * (i % 5 - i / 5);
                y = -17 * (6 - i % 5 - i / 5);
            }
            
            UIImageView *image_tree = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            image_tree.bounds = CGRectMake(0, 0, 50, 50);
            image_tree.center = CGPointMake(_image_bg.width * 0.5 + x, _image_bg.height * 0.5 + y - 10 - arc4random_uniform(50));
            [_image_bg addSubview:image_tree];
            
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[image_tree]];
            collision.translatesReferenceBoundsIntoBoundary = NO;
            [collision addBoundaryWithIdentifier:@"line" fromPoint:CGPointMake(0, _image_bg.height * 0.5 + y + image_tree.height * 0.5) toPoint:CGPointMake(YC_ScreenWidth, _image_bg.height * 0.5 + y + image_tree.height * 0.5)];
            
            [self.dynamicArray[i] addBehavior:[[UIGravityBehavior alloc] initWithItems:@[image_tree]]];
            [self.dynamicArray[i] addBehavior:collision];
        }
    }
}

@end
