//
//  YCMainViewController.m
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <DateTools/DateTools.h>
#import <YCHelpKit/UIAlertController+Category.h>

#import "YCMainViewController.h"
#import "YCLoginViewController.h"
#import "YCAnalysisViewController.h"
#import "YCRankTableViewController.h"
#import "YCSettingTableViewController.h"
#import "YCMainTitleLabel.h"
#import "YCMainTreeImageView.h"
#import "YCMainBackgroundImageView.h"
#import "YCCircularSlider.h"
#import "YCCountDownLabel.h"
#import "YCGlobalConst.h"
#import "YCMainBiz.h"
#import "YCNotificationUtils.h"
#import "YCTreeTimeUtils.h"
#import "YCSetting.h"
#import "YCMainParam.h"

typedef NS_ENUM(NSUInteger, YCMainViewStatus) {
    YCMainViewStatusInit = 0,
    YCMainViewStatusExec = 1,
    YCMainViewStatusFinish = 2
};

static BOOL _locked;

@interface YCMainViewController () <YCCountDownLabelDelegate> {
    long _userId;
}

@property (weak, nonatomic) IBOutlet UIButton *btn_analysis;
@property (weak, nonatomic) IBOutlet UIButton *btn_rank;
@property (weak, nonatomic) IBOutlet UIButton *btn_setting;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;
@property (weak, nonatomic) IBOutlet UIButton *btn_stop;
@property (weak, nonatomic) IBOutlet UIButton *btn_back;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;

@property (weak, nonatomic) IBOutlet YCMainTitleLabel *label_title;
@property (weak, nonatomic) IBOutlet YCMainTreeImageView *image_tree;
@property (weak, nonatomic) IBOutlet YCMainBackgroundImageView *image_bg;
@property (weak, nonatomic) IBOutlet YCCircularSlider *slider;
@property (weak, nonatomic) IBOutlet YCCountDownLabel *label_countDownTime;

- (IBAction)clickAnalysis;
- (IBAction)clickRank;
- (IBAction)clickSetting;
- (IBAction)clickStart;
- (IBAction)clickStop;
- (IBAction)clickBack;

@end

@implementation YCMainViewController

- (void)setupViewWithStatus:(YCMainViewStatus)status {
    switch (status) {
        case YCMainViewStatusInit:
            _btn_analysis.hidden = NO;
            _btn_rank.hidden = NO;
            _btn_setting.hidden = NO;
            _btn_start.hidden = NO;
            _btn_stop.hidden = YES;
            _btn_back.hidden = YES;
            _btn_share.hidden = YES;
            _label_countDownTime.hidden = NO;
            _slider.hidden = NO;
            break;
        case YCMainViewStatusExec:
            _btn_analysis.hidden = YES;
            _btn_rank.hidden = YES;
            _btn_setting.hidden = YES;
            _btn_start.hidden = YES;
            _btn_stop.hidden = NO;
            _btn_back.hidden = YES;
            _btn_share.hidden = YES;
            _label_countDownTime.hidden = NO;
            _slider.hidden = YES;
            break;
        case YCMainViewStatusFinish:
            _btn_analysis.hidden = YES;
            _btn_rank.hidden = YES;
            _btn_setting.hidden = YES;
            _btn_start.hidden = YES;
            _btn_stop.hidden = YES;
            _btn_back.hidden = NO;
            _btn_share.hidden = NO;
            _label_countDownTime.hidden = YES;
            _slider.hidden = YES;
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, YCNotificationOff, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, YCNotificationOn, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    if (YC_IPhoneX) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    
    _label_countDownTime.delegate = self;
    [_slider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [self setupViewWithStatus:YCMainViewStatusInit];
    _userId = [YCTreeTimeUtils setting].userId;
}

- (void)dealloc {
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - 锁屏/home键监听

static void screenLockStateChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSString *lockstate = (__bridge NSString *) name;
    _locked = [lockstate isEqualToString:(__bridge NSString *) YCNotificationOff];
}

- (void)applicationWillResignActiveNotification:(NSNotification *)notification {
    if (!_locked && _label_countDownTime.isStart) {
        [self stop];
    }
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
    _locked = NO;
}

#pragma mark - 代理回调

- (void)sliderValueChanged {
    [_image_tree setupImageWithProgress:_slider.progress];
    _label_countDownTime.countDownTime = (_slider.progress * YC_Main_Grow_Second) + YC_Main_Init_Second;
}

- (void)countDownLabel:(YCCountDownLabel *)countDownLabel timeout:(int)timeout {
    if (timeout % 10 == 0) {
        [_label_title setupRandomText];
    }
    [_image_tree setupImageWithTime:countDownLabel.countDownTime - timeout];
}

- (void)countDownLabelTimeOver:(YCCountDownLabel *)countDownLabel {
    // 由于在iOS10之前 首屏app的通知不会播放通知音
    if (!iOS10_OR_Later && !_locked) {
        [YCNotificationUtils playNotificationSound:@"sms-received1.caf"];
    }
    [_label_title setupSuccessText];
    [_image_tree setupImageWithTime:countDownLabel.countDownTime];
    [self setupViewWithStatus:YCMainViewStatusFinish];
    
    YCMainParam *param = [YCMainBiz mainLastWithUserId:_userId];
    [YCMainBiz mainUpdateWithID:param.ID status:YCMainStatusSuccess];
    [YCMainBiz mainWithParam:param success:^{
        [YCMainBiz mainUpdateWithID:param.ID sync:YES];
    } failure:^(NSString *errorMsg) {
        YCLog(@"%@", errorMsg);
    }];
}

#pragma mark - 按钮点击

- (IBAction)clickAnalysis {
    YCAnalysisViewController *vc = [[YCAnalysisViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickRank {
    YCSetting *setting = [YCTreeTimeUtils setting];
    if (setting.loginName.length && setting.loginPassword.length) {
        [self.navigationController pushViewController:[[YCRankTableViewController alloc] init] animated:YES];
    } else {
        [self.navigationController pushViewController:[[YCLoginViewController alloc] init] animated:YES];
    }
}

- (IBAction)clickSetting {
    YCSettingTableViewController *vc = [[YCSettingTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickStart {
    [self setupViewWithStatus:YCMainViewStatusExec];
    [_label_countDownTime start];
    // 添加本地通知
    [YCNotificationUtils addLocalNotificationWithTitle:@"恭喜" body:@"您种植了健康的树" soundName:@"sms-received1.caf" timeInterval:_label_countDownTime.countDownTime];
    // 插入数据
    YCMainParam *param = [[YCMainParam alloc] init];
    param.score = _label_countDownTime.countDownTime;
    param.createTime = [[NSDate date] formattedDateWithFormat:@"yyyy-MM-dd"];
    param.status = YCMainStatusStart;
    param.userId = _userId;
    param.sync = NO;
    [YCMainBiz mainInsertWithParam:param];
}

- (void)stop {
    [_label_title setupFailureText];
    [_image_tree setupImageWithDead];
    [_image_bg setupImageWithDead];
    [self setupViewWithStatus:YCMainViewStatusFinish];
    [_label_countDownTime stop];
    
    // 删除本地通知
    [YCNotificationUtils removeAllNotification];
    
    YCMainParam *param = [YCMainBiz mainLastWithUserId:_userId];
    [YCMainBiz mainUpdateWithID:param.ID status:YCMainStatusFailure];
}

- (IBAction)clickStop {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self stop];
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要扼杀这颗树吗？" message:@"您充满活力、绿意盎然的树将会枯萎" preferredStyle:UIAlertControllerStyleAlert alertActions:@[alertAction]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)clickBack {
    [_label_title setupInitText];
    [_image_bg setupImageWithLive];
    _slider.progress = 0;
    [self setupViewWithStatus:YCMainViewStatusInit];
}

@end
