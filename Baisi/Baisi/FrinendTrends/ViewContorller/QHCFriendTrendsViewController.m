//
//  QHCFriendTrendsViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCFriendTrendsViewController.h"
#import "QHCTestViewController.h"
#import "QHCLoginViewController.h"
@interface QHCFriendTrendsViewController ()

@end

@implementation QHCFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"关注";
    
    UIBarButtonItem *item = [UIBarButtonItem barBtuttonItemImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendTriendClick)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [self setupSubview];
}

- (void)setupSubview
{
    CGFloat pointY = 150.0f;
    
    UIImage *imag = [UIImage imageNamed:@"header_cry_icon"];
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(screenW/2 - imag.size.width/2*QHCScreen_WRtio, pointY, imag.size.width * QHCScreen_WRtio, imag.size.height)];
    iconV.image = imag;
    [self.view addSubview:iconV];
    
    pointY += iconV.frame.size.height + 50.0f;
    
    NSString *helloText = @"像音符一样苏醒,整片天空做背景,背起行囊的这个剪影,旅程孤独而坚定,一边走一边唱出的歌曲,配这场没有剧本的电影,我或许是边走边在等你,等一些无法预设的美丽,我在路上在路上,衣袂飘荡长发飞扬,期待路上遇上,突如其来的那一场,谁在路旁在路旁,听见我自由放声唱,和我一样背上行囊,脚步丈量远方";
    UILabel *helloLbl = [[UILabel alloc] init];
    helloLbl.text = helloText;
    helloLbl.textColor = QHCRandom_Color
    helloLbl.font = [UIFont systemFontOfSize:16];
    helloLbl.numberOfLines = 0;
    helloLbl.textAlignment = NSTextAlignmentCenter;
    // 多行计算
    CGSize size = [helloLbl.text boundingRectWithSize:CGSizeMake(300*QHCScreen_WRtio, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    // 单行计算
//    CGSize size1 = [helloLbl.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    helloLbl.frame = CGRectMake(screenW/2 - size.width/2, pointY, size.width, size.height);
    [self.view addSubview:helloLbl];
    

    pointY += size.height + 50.0f;
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"立即登录注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    loginBtn.frame = CGRectMake(screenW/2 - 200.0f*QHCScreen_WRtio/2, pointY, 200.0f*QHCScreen_WRtio, 50.0f);
    [loginBtn addTarget:self action:@selector(loingClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
}

- (void)loingClick
{
    [self presentViewController:[[QHCLoginViewController alloc] init] animated:YES completion:nil];

}

- (void)friendTriendClick
{
    QHCTestViewController *testVc = [[QHCTestViewController alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
