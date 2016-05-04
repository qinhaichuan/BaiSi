//
//  QHCAllViewController.m
//  Baisi
//
//  Created by QHC on 5/3/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCAllViewController.h"
#import "QHCTopicModel.h"
#import "QHCTopicCell.h"
@interface QHCAllViewController()

@property(nonatomic, strong) NSMutableArray *topicModelArr;
@property(nonatomic, copy) NSString *maxTime;

@end

@implementation QHCAllViewController

- (NSMutableArray *)topicModelArr
{
    if (!_topicModelArr) {
        _topicModelArr = [NSMutableArray array];
    }
    return _topicModelArr;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTable];
    [self setupRefresh];
    
}


- (void)setupTable
{
    self.tableView.backgroundColor = QHCBgColor
    self.tableView.rowHeight = 100*QHCScreen_HRtio;
    

}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushResfresh)];

}

- (void)pullRefresh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"type"] = @"1";
    params[@"c"] = @"data";
    
//    [SVProgressHUD showWithStatus:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
//        [SVProgressHUD dismiss];
        QHCLog(@"==--------===%@", responseDict);
        if (QHCDict(responseDict)) {
            weakSelf.maxTime = responseDict[@"info"][@"maxtime"];
            weakSelf.topicModelArr = [QHCTopicModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            
            [weakSelf.tableView reloadData];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *errorMess) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showWithStatus:@"加载失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
        
    }];
    
    
    
}

- (void)pushResfresh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"type"] = @"1";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxTime;
    
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        QHCLog(@"++========++%@", responseDict);
        if (QHCDict(responseDict)) {
            NSArray *moreArr = [QHCTopicModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            [weakSelf.topicModelArr addObjectsFromArray:moreArr];
        }
        
        
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *errorMess) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];

}


#pragma mark ----- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicModelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QHCTopicCell cellWith:tableView];
}



@end
