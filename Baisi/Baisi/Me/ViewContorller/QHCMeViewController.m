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
    self.tableView.contentInset = UIEdgeInsetsMake(10*QHCScreen_HRtio, 0, 0, 0);
    self.tableView.backgroundColor = QHCColor(206, 206, 206, 1);
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

#pragma mark ---- UITableView data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[QHCMeFooterView alloc] init];
}

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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
