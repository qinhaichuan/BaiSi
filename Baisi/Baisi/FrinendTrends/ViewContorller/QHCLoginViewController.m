//
//  QHCLoginViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCLoginViewController.h"

@interface QHCLoginViewController ()

@end

@implementation QHCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imagV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imagV.image = [UIImage imageNamed:@"login_register_background"];
    [self.view addSubview:imagV];
    
    [self setupSubviews];
    
    
}

- (void)setupSubviews
{
    CGFloat pointY = 64.0f * QHCScreen_HRtio;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imag = [UIImage imageNamed:@"login_close_icon"];
    [backBtn setBackgroundImage:imag forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(15*QHCScreen_WRtio, pointY*QHCScreen_HRtio, imag.size.width, imag.size.height);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    pointY += backBtn.frame.size.height + 50.0f * QHCScreen_HRtio;

    UIImageView *textFieldImageV = [[UIImageView alloc] init];
    textFieldImageV.userInteractionEnabled = NO;
    UIImage *bgImage = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    textFieldImageV.image = bgImage;
    textFieldImageV.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2, pointY, 300.0f*QHCScreen_WRtio, 100.0f*QHCScreen_HRtio);
    [self.view addSubview:textFieldImageV];

    UITextField *phoneNumTextField = [[UITextField alloc] init];
    phoneNumTextField.placeholder = @"请输入手机号";
    // 只读属性, 用kvc
    UILabel *placeHolder = [phoneNumTextField valueForKey:@"placeholderLabel"];
    placeHolder.textColor = QHCRandom_Color
    phoneNumTextField.tintColor = QHCRandom_Color
    phoneNumTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.view addSubview:phoneNumTextField];

    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.placeholder = @"请输入密码";
    UILabel *pwdLbl = [pwdTextField valueForKey:@"placeholderLabel"];
    pwdLbl.textColor = QHCRandom_Color
    pwdTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY + textFieldImageV.frame.size.height/2, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.view addSubview:pwdTextField];

    
    pointY += textFieldImageV.frame.size.height + 30.0f * QHCScreen_HRtio;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *loginBtnBg = [UIImage imageNamed:@"loginBtnBg"];
    // 防止拉伸变形
    UIImage *newLoginBtnBg = [loginBtnBg resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1, loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    UIImage *loginBtnBgClick = [UIImage imageNamed:@"loginBtnBgClick"];
    UIImage *newLoginBtnBgClick = [loginBtnBgClick resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1, loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    [loginBtn setBackgroundImage:newLoginBtnBg forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:newLoginBtnBgClick forState:UIControlStateHighlighted];
    loginBtn.titleLabel.text = @"立即登录";
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(textFieldImageV.frame.origin.x, pointY, textFieldImageV.frame.size.width, 30.0f*QHCScreen_HRtio);
    [self.view addSubview:loginBtn];
    
    pointY += loginBtn.frame.size.height + 30.0f * QHCScreen_HRtio;
    
    
    
}

#pragma mark ------- ClickEvent

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
