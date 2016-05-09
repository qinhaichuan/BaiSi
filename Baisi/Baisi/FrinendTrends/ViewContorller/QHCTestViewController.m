//
//  QHCTestViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTestViewController.h"
#import "QHCRecommendModel.h"
#import "QHCLeftCell.h"
#import "QHCRightCell.h"
@interface QHCTestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView *leftView;
@property(nonatomic, weak) UITableView *rightView;
@property(nonatomic, strong) NSMutableArray *recommendModelArr;

@end

@implementation QHCTestViewController

- (NSMutableArray *)recommendModelArr
{
    if (!_recommendModelArr) {
        _recommendModelArr = [NSMutableArray array];
    }
    return _recommendModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Test";
    self.view.backgroundColor = QHCBgColor;
    [self setTableView];
    [self getDate];
}

- (void)setTableView
{
    UITableView *leftView = [[UITableView alloc] init];
    self.leftView = leftView;
    leftView.delegate = self;
    leftView.dataSource = self;
    leftView.backgroundColor = QHCBgColor
//    leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftView.frame = CGRectMake(0, 0, 70*QHCScreen_WRtio, self.view.height);
//    UIEdgeInsets insets1 = UIEdgeInsetsMake(64*QHCScreen_HRtio, 0, 0, 0);
//    leftView.scrollIndicatorInsets = insets1;
//    leftView.contentInset = insets;
    [self.view addSubview:leftView];
    
    UITableView *rightView = [[UITableView alloc] init];
    self.rightView = rightView;
    rightView.delegate = self;
    rightView.dataSource = self;
    rightView.frame = CGRectMake(70*QHCScreen_HRtio, 64*QHCScreen_WRtio, self.view.width - 70*QHCScreen_WRtio, self.view.height);
    UIEdgeInsets insets2 = UIEdgeInsetsMake(0, 0, 60*QHCScreen_HRtio, 0);
    rightView.scrollIndicatorInsets = insets2;
    rightView.contentInset = insets2;
    [self.view addSubview:rightView];
    
    
}


- (void)getDate
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        
        if (QHCDict(responseDict)) {
            
            weakSelf.recommendModelArr = [QHCRecommendModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
        }

        [SVProgressHUD dismiss];
        [weakSelf.leftView reloadData];
    } failure:^(NSError *errorMess) {
        [SVProgressHUD showWithStatus:@"加载失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];

}



#pragma mark ----- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftView) {
        return self.recommendModelArr.count;
    }else{
        return 30;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftView) {
        QHCLeftCell *cell = [QHCLeftCell cellWithTableView:tableView];
        cell.recommendModel = self.recommendModelArr[indexPath.row];
        QHCLog(@"%zd", self.recommendModelArr.count);
        return cell;
    }else{
        QHCRightCell *cell = [QHCRightCell cellWithTableView:tableView];
        cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
