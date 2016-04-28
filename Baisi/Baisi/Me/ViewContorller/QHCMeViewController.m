//
//  QHCMeViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCMeViewController.h"
#import "QHCSettingViewController.h"
@interface QHCMeViewController ()

@end

@implementation QHCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    UIBarButtonItem *item1 = [UIBarButtonItem barBtuttonItemImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *item2 = [UIBarButtonItem barBtuttonItemImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[item2, item1];

}

- (void)moonClick
{
    QHCLogFunc;

}

- (void)setting
{
    QHCSettingViewController *settingVc = [[QHCSettingViewController alloc] init];
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
