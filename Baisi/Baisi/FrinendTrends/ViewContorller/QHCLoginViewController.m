//
//  QHCLoginViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCLoginViewController.h"
#import "QHCButton.h"
@interface QHCLoginViewController ()

@property(nonatomic, weak) UIView *middleLoginView;
@property(nonatomic, weak) UIView *middleRegisterView;

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
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn setTitle:@"已有账号?" forState:UIControlStateSelected];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    registerBtn.selected = YES;
    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    CGSize registerBtnSize = [@"已有账号?" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
    registerBtn.frame = CGRectMake(screenW - registerBtnSize.width - 15*QHCScreen_WRtio, pointY, registerBtnSize.width, registerBtnSize.height);
    [self.view addSubview:registerBtn];

    
    pointY += backBtn.frame.size.height + 50.0f * QHCScreen_HRtio;

    // 登录View
    UIView *middleLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, screenW, 200.0f*QHCScreen_WRtio)];
    middleLoginView.backgroundColor = nil;
    self.middleLoginView = middleLoginView;
    [self.view addSubview:middleLoginView];
    
    UIImageView *textFieldImageV = [[UIImageView alloc] init];
    textFieldImageV.userInteractionEnabled = NO;
    UIImage *bgImage = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    textFieldImageV.image = bgImage;
//    textFieldImageV.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2, pointY, 300.0f*QHCScreen_WRtio, 100.0f*QHCScreen_HRtio);
    textFieldImageV.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2, 0, 300.0f*QHCScreen_WRtio, 100.0f*QHCScreen_HRtio);
    [self.middleLoginView addSubview:textFieldImageV];

    UITextField *phoneNumTextField = [[UITextField alloc] init];
    phoneNumTextField.placeholder = @"手机号";
    // 只读属性, 用kvc
    UILabel *placeHolder = [phoneNumTextField valueForKey:@"placeholderLabel"];
    placeHolder.textColor = QHCRandom_Color
    phoneNumTextField.tintColor = QHCRandom_Color
//    phoneNumTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    phoneNumTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, 0, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.middleLoginView addSubview:phoneNumTextField];

    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.placeholder = @"密码";
    UILabel *pwdLbl = [pwdTextField valueForKey:@"placeholderLabel"];
    pwdLbl.textColor = QHCRandom_Color
//    pwdTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY + textFieldImageV.frame.size.height/2, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    pwdTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, textFieldImageV.frame.size.height/2, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.middleLoginView addSubview:pwdTextField];

    
//    pointY += textFieldImageV.frame.size.height + 30.0f * QHCScreen_HRtio;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *loginBtnBg = [UIImage imageNamed:@"loginBtnBg"];
    // 防止拉伸变形
    UIImage *newLoginBtnBg = [loginBtnBg resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1, loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    UIImage *loginBtnBgClick = [UIImage imageNamed:@"loginBtnBgClick"];
    UIImage *newLoginBtnBgClick = [loginBtnBgClick resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1, loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    [loginBtn setBackgroundImage:newLoginBtnBg forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:newLoginBtnBgClick forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    loginBtn.frame = CGRectMake(textFieldImageV.frame.origin.x, pointY, textFieldImageV.frame.size.width, 30.0f*QHCScreen_HRtio);
    loginBtn.frame = CGRectMake(textFieldImageV.frame.origin.x, textFieldImageV.frame.size.height + 20.0f * QHCScreen_HRtio, textFieldImageV.frame.size.width, 30.0f*QHCScreen_HRtio);
    [self.middleLoginView addSubview:loginBtn];
    
//    pointY += loginBtn.frame.size.height + 30.0f * QHCScreen_HRtio;
    
    UIButton *forgetPWDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPWDBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPWDBtn setTintColor:[UIColor whiteColor]];
    forgetPWDBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    forgetPWDBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetPWDBtn.frame = CGRectMake(screenW - CGRectGetMinX(textFieldImageV.frame) - 100.0f*QHCScreen_WRtio, CGRectGetMaxY(loginBtn.frame) + 30.0f*QHCScreen_HRtio, 100.0f*QHCScreen_WRtio, 30.0f*QHCScreen_HRtio);
    [forgetPWDBtn addTarget:self action:@selector(forgetPWDClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleLoginView addSubview:forgetPWDBtn];
    
    [self creatRegisterView];
    
    pointY += middleLoginView.frame.size.height;
    
    
    UILabel *quickLogLbl = [[UILabel alloc] init];
    quickLogLbl.text = @"快速登录";
    quickLogLbl.font = [UIFont systemFontOfSize:14];
    quickLogLbl.textColor = [UIColor whiteColor];
    CGSize quickLogLblSize = [quickLogLbl.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    quickLogLbl.frame = CGRectMake(0, 0, quickLogLblSize.width, quickLogLblSize.height);
    quickLogLbl.center = CGPointMake(screenW/2, screenH - 180*QHCScreen_HRtio);
    [self.view addSubview:quickLogLbl];
    
    UIImageView *leftImageV = [[UIImageView alloc] init];
    UIImage *leftImage = [UIImage imageNamed:@"login_register_left_line"];
    leftImageV.image = leftImage;
    leftImageV.frame = CGRectMake(screenW/2 - quickLogLblSize.width/2 - 10*QHCScreen_WRtio - leftImage.size.width, quickLogLbl.center.y, leftImage.size.width, leftImage.size.height);
    [self.view addSubview:leftImageV];
    
    UIImageView *rightImageV = [[UIImageView alloc] init];
    UIImage *rightImage = [UIImage imageNamed:@"login_register_right_line"];
    rightImageV.image = rightImage;
    rightImageV.frame = CGRectMake(screenW/2 + quickLogLblSize.width/2 + 5*QHCScreen_WRtio, quickLogLbl.center.y, leftImage.size.width, leftImage.size.height);
    [self.view addSubview:rightImageV];
    
    QHCButton *qqBtn = [[QHCButton alloc] initWithTitle:@"QQ登录" image:@"login_QQ_icon" highImage:@"login_QQ_icon_click"];
    qqBtn.frame = CGRectMake(20.0f*QHCScreen_WRtio, screenH  - 160.0f*QHCScreen_HRtio, 70.0f*QHCScreen_WRtio, 70.0f*QHCScreen_HRtio);
    [self.view addSubview:qqBtn];
    
    QHCButton *tencentBtn = [[QHCButton alloc] initWithTitle:@"腾讯微博" image:@"login_tecent_icon" highImage:@"login_tecent_icon_click"];
    tencentBtn.frame = CGRectMake(0, screenH - 160.0f*QHCScreen_HRtio, 70.0f*QHCScreen_WRtio, 70.0f*QHCScreen_HRtio);
    tencentBtn.center = CGPointMake(screenW/2, tencentBtn.frame.origin.y + tencentBtn.frame.size.height/2);
    [self.view addSubview:tencentBtn];
    
    QHCButton *sinaBtn = [[QHCButton alloc] initWithTitle:@"微博登录" image:@"login_sina_icon" highImage:@"login_sina_icon_click"];
    sinaBtn.frame = CGRectMake(screenW - 20.0f*QHCScreen_WRtio - 70.0f*QHCScreen_WRtio, screenH - 160.0f*QHCScreen_HRtio, 70.0f*QHCScreen_WRtio, 70.0f*QHCScreen_HRtio);
    [self.view addSubview:sinaBtn];
    
}

- (void)creatRegisterView
{
    
    // 注册View
    UIView *middleRegisterView = [[UIView alloc] initWithFrame:CGRectMake(screenW, self.middleLoginView.frame.origin.y, screenW, 200.0f*QHCScreen_WRtio)];
    middleRegisterView.backgroundColor = nil;
    self.middleRegisterView = middleRegisterView;
    [self.view addSubview:middleRegisterView];
    
    UIImageView *textFieldImageV = [[UIImageView alloc] init];
    textFieldImageV.userInteractionEnabled = NO;
    UIImage *bgImage = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    textFieldImageV.image = bgImage;
    //    textFieldImageV.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2, pointY, 300.0f*QHCScreen_WRtio, 100.0f*QHCScreen_HRtio);
    textFieldImageV.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2, 0, 300.0f*QHCScreen_WRtio, 100.0f*QHCScreen_HRtio);
    [self.middleRegisterView addSubview:textFieldImageV];
    
    UITextField *phoneNumTextField = [[UITextField alloc] init];
    phoneNumTextField.placeholder = @"请输入手机号";
    // 只读属性, 用kvc
    UILabel *placeHolder = [phoneNumTextField valueForKey:@"placeholderLabel"];
    placeHolder.textColor = QHCRandom_Color
    phoneNumTextField.tintColor = QHCRandom_Color
    //    phoneNumTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    phoneNumTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, 0, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.middleRegisterView addSubview:phoneNumTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.placeholder = @"请输入密码";
    UILabel *pwdLbl = [pwdTextField valueForKey:@"placeholderLabel"];
    pwdLbl.textColor = QHCRandom_Color
    //    pwdTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, pointY + textFieldImageV.frame.size.height/2, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    pwdTextField.frame = CGRectMake(screenW/2 - 300.0f*QHCScreen_WRtio/2 + 10*QHCScreen_WRtio, textFieldImageV.frame.size.height/2, textFieldImageV.frame.size.width, textFieldImageV.frame.size.height/2);
    [self.middleRegisterView addSubview:pwdTextField];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *loginBtnBg = [UIImage imageNamed:@"loginBtnBg"];
    // 防止拉伸变形
    UIImage *newLoginBtnBg = [loginBtnBg resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1, loginBtnBg.size.height * 0.1, loginBtnBg.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    UIImage *loginBtnBgClick = [UIImage imageNamed:@"loginBtnBgClick"];
    UIImage *newLoginBtnBgClick = [loginBtnBgClick resizableImageWithCapInsets:UIEdgeInsetsMake(loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1, loginBtnBgClick.size.height * 0.1, loginBtnBgClick.size.width * 0.1) resizingMode:UIImageResizingModeStretch];
    [loginBtn setBackgroundImage:newLoginBtnBg forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:newLoginBtnBgClick forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    loginBtn.frame = CGRectMake(textFieldImageV.frame.origin.x, pointY, textFieldImageV.frame.size.width, 30.0f*QHCScreen_HRtio);
    loginBtn.frame = CGRectMake(textFieldImageV.frame.origin.x, textFieldImageV.frame.size.height + 20.0f * QHCScreen_HRtio, textFieldImageV.frame.size.width, 30.0f*QHCScreen_HRtio);
    [self.middleRegisterView addSubview:loginBtn];

    
    
    
}

#pragma mark ------- ClickEvent

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;

    [UIView animateWithDuration:0.25 animations:^{
        if (sender.selected) {
            self.middleLoginView.center = CGPointMake(-screenW/2, CGRectGetMaxY(self.middleLoginView.frame) - self.middleLoginView.frame.size.height/2);
            self.middleRegisterView.center = CGPointMake(screenW/2, CGRectGetMaxY(self.middleRegisterView.frame) - self.middleRegisterView.frame.size.height/2);
            [self.view layoutIfNeeded];

        }else{
            self.middleLoginView.center = CGPointMake(screenW/2, CGRectGetMaxY(self.middleLoginView.frame) - self.middleLoginView.frame.size.height/2);
            self.middleRegisterView.center = CGPointMake(screenW + screenW/2, CGRectGetMaxY(self.middleRegisterView.frame) - self.middleRegisterView.frame.size.height/2);
            [self.view layoutIfNeeded];
            
        }

    }];
    
    [self.view endEditing:YES];
}

- (void)forgetPWDClick:(UIButton *)sender
{
    QHCLogFunc
}





#pragma mark -------- ViewMethods
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
