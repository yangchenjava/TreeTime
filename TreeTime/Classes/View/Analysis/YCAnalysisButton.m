//
//  YCAnalysisButton.m
//  TreeTime
//
//  Created by yangc on 16/12/13.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCAnalysisButton.h"
#import "YCGlobalConst.h"

@implementation YCAnalysisButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = contentRect.size;
    return CGRectMake(size.width * 0.5, 0, (size.width - YC_Base_Margin * 2) * 0.5, size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGSize size = contentRect.size;
    return CGRectMake(YC_Base_Margin, 0, (size.width - YC_Base_Margin * 2) * 0.5, size.height);
}

@end
