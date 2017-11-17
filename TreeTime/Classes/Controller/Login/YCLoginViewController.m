//
//  YCLoginViewController.m
//  TreeTime
//
//  Created by yangc on 16/12/8.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <YCHelpKit/MBProgressHUD+Category.h>

#import "YCLoginViewController.h"
#import "YCLoginBiz.h"
#import "YCLoginParam.h"
#import "YCTreeTimeUtils.h"

@interface YCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField_username;
@property (weak, nonatomic) IBOutlet UITextField *textField_password;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UIButton *btn_fast;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fastBtnBottomConstraint;

- (IBAction)clickLogin;
- (IBAction)clickFast;

@end

@implementation YCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.navigationItem.title = @"请登录";
        _btn_fast.hidden = YES;
    } else {
        _btn_fast.hidden = NO;
    }
    [self setupTextFieldUsername];
    [self setupTextFieldPassword];
    [self setupBtnFast];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewLayoutMarginsDidChange {
    [super viewLayoutMarginsDidChange];
    self.fastBtnBottomConstraint.constant = 30 + YC_TabBarBottomSafeMargin;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)setupTextFieldUsername {
    _textField_username.delegate = self;

    _textField_username.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: YC_Color_RGB(136, 224, 198)}];
    
    _textField_username.layer.cornerRadius = 23.0;
    _textField_username.layer.masksToBounds = YES;
    _textField_username.layer.borderWidth = 1.5;
    _textField_username.layer.borderColor = YC_Color_RGB(136, 224, 198).CGColor;
}

- (void)setupTextFieldPassword {
    _textField_password.delegate = self;
    
    _textField_password.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: YC_Color_RGB(136, 224, 198)}];
    
    _textField_password.layer.cornerRadius = 23.0;
    _textField_password.layer.masksToBounds = YES;
    _textField_password.layer.borderWidth = 1.5;
    _textField_password.layer.borderColor = YC_Color_RGB(136, 224, 198).CGColor;
}

- (void)setupBtnFast {
    _btn_fast.titleLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"先让我感受一下" attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    [_btn_fast setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn_fast setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.layer.borderColor = YC_Color_RGB(136, 224, 198).CGColor;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _textField_username) {
        [_textField_password becomeFirstResponder];
    } else {
        [self clickLogin];
    }
    return YES;
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGFloat ty = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y - self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

- (IBAction)clickLogin {
    if (_textField_username.text.length && _textField_password.text.length) {
        [MBProgressHUD showMessage:@"登录中，请稍后..." mask:YES];
        YCLoginParam *param = [[YCLoginParam alloc] init];
        param.loginName = _textField_username.text;
        param.loginPassword = _textField_password.text;
        [YCLoginBiz loginWithParam:param success:^{
            [MBProgressHUD hideHUD];
            [YCTreeTimeUtils setupRootViewController];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:errorMsg];
        }];
    } else {
        [MBProgressHUD showError:@"用户名或密码不能为空"];
    }
}

- (IBAction)clickFast {
    [YCTreeTimeUtils setupRootViewControllerWithMain];
}

@end
