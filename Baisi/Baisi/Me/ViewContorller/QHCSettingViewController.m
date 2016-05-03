//
//  QHCSettingViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSettingViewController.h"
#import "QHCClearCacheCell.h"
#import "QHCOtherCell.h"
@interface QHCSettingViewController ()

@end

@implementation QHCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = QHCBgColor
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10*QHCScreen_HRtio;
    self.tableView.contentInset = UIEdgeInsetsMake(-25*QHCScreen_HRtio, 0, 0, 0);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
            QHCClearCacheCell *cacherCell = [QHCClearCacheCell cellWith:tableView];
            return cacherCell;
//        }
    }else{
        QHCOtherCell *cell = [QHCOtherCell cellWith:tableView];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"检查更新";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"给我们评分";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"推送设置";
        }else{
            cell.textLabel.text = @"关于我们";
        }
        return cell;
    }
}






@end
