//
//  QHCSubTagViewController.m
//  Baisi
//
//  Created by QHC on 4/29/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSubTagViewController.h"
#import "QHCSubTagModel.h"
#import "QHCSubTagCell.h"
@interface QHCSubTagViewController ()<UITableViewDataSource>

@property(nonatomic, strong) NSArray *subTagModelArr;

@end

@implementation QHCSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getData];
    
}

- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [SVProgressHUD showWithStatus:@"请求数据中..."];
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        
        [SVProgressHUD dismiss];
        
        QHCLog(@"返回3: %@", responseDict);
        
        if (responseDict) {
            
            self.subTagModelArr = [QHCSubTagModel mj_objectArrayWithKeyValuesArray:responseDict];
//            QHCLog(@"=======%@", self.subTagModelArr);
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *errorMess) {
//        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD showWithStatus:@"网络请求失败..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
    }];

}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.subTagModelArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    QHCSubTagCell *cell = [QHCSubTagCell cellWithTableView:tableView];
    cell.subTagModel = self.subTagModelArr[indexPath.row];
    return cell;
}

#pragma mark ----- Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 松手后去除阴影
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QHCLogFunc
}



@end
