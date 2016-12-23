//
//  YCAnalysisViewController.m
//  TreeTime
//
//  Created by yangc on 16/12/11.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <YCHelpKit/UIBarButtonItem+Category.h>

#import "YCAnalysisViewController.h"
#import "YCAnalysisTopView.h"
#import "YCAnalysisBottomView.h"
#import "YCGlobalConst.h"

@interface YCAnalysisViewController ()

@end

@implementation YCAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupNavigationBar];
    [self setupView];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"我的森林";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
}

- (void)setupView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"blur_background"];
    [self.view addSubview:imageView];
    
    YCAnalysisTopView *topView = [YCAnalysisTopView topViewWithFrame:CGRectMake(0, 0, YC_ScreenWidth, YC_Analysis_H_Bottom)];
    [self.view addSubview:topView];
    
    YCAnalysisBottomView *bottomView = [YCAnalysisBottomView bottomViewWithFrame:CGRectMake(0, YC_Analysis_H_Bottom, YC_ScreenWidth, YC_ScreenHeight - YC_Analysis_H_Bottom)];
    bottomView.delegate = topView;
    [bottomView setupInitData];
    [self.view addSubview:bottomView];
}

@end
