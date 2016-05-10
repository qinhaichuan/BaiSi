//
//  QHCMeViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCMeViewController.h"
#import "QHCSettingViewController.h"
#import "QHCMeCell.h"
#import "QHCMeFooterView.h"
#import "QHCLoginViewController.h"
@interface QHCMeViewController ()

@end

@implementation QHCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigation];
    [self setTable];
}

- (void)setNavigation
{
    self.navigationItem.title = @"我";
    UIBarButtonItem *item1 = [UIBarButtonItem barBtuttonItemImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *item2 = [UIBarButtonItem barBtuttonItemImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[item2, item1];
}

- (void)setTable
{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10*QHCScreen_HRtio;
    self.tableView.contentInset = UIEdgeInsetsMake(-25*QHCScreen_HRtio, 0, 0, 0);
    self.tableView.backgroundColor = QHCColor(206, 206, 206, 1);
    self.tableView.tableFooterView = [[QHCMeFooterView alloc] init];
}

- (void)moonClick
{
    QHCLogFunc;

}

- (void)setting
{
    QHCSettingViewController *settingVc = [[QHCSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];

}

#pragma mark ---- UITableView data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[QHCMeFooterView alloc] init];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHCMeCell *cell = [QHCMeCell cellWith:tableView];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }else{
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QHCLoginViewController *logVc = [[QHCLoginViewController alloc] init];
//             UITabBarController *root = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            UINavigationController *nav = root.selectedViewController;
        [self presentViewController:logVc animated:YES completion:nil];
    }

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
