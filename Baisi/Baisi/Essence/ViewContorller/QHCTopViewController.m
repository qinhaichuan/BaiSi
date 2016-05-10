//
//  QHCTopViewController.m
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTopViewController.h"
#import "QHCTopicCell.h"
#import "QHCNewViewController.h"
#import "QHCCommentViewController.h"
@interface QHCTopViewController()

@property(nonatomic, strong) NSMutableArray<QHCTopicModel *> *topicModelArr;
@property(nonatomic, copy) NSString *maxTime;

@end

@implementation QHCTopViewController

- (QHCTopicType)type
{
    return 0;
}

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
    //    self.tableView.rowHeight = 200*QHCScreen_HRtio;
    //    self.tableView.estimatedRowHeight = 200.0;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(35*QHCScreen_HRtio, 0, 50*QHCScreen_HRtio, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    // 自动设置透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushResfresh)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
    
}

- (void)pullRefresh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.judgeNew;
    params[@"type"] = @"1";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        QHCLog(@"==--------===%@", responseDict);
        if (QHCDict(responseDict)) {
            weakSelf.maxTime = responseDict[@"info"][@"maxtime"];
            weakSelf.topicModelArr = [QHCTopicModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            
        }
        
        [weakSelf.tableView reloadData];
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
    params[@"a"] = self.judgeNew;
    params[@"type"] = @(self.type);
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxTime;
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        QHCLog(@"++========++%@", responseDict);
        [SVProgressHUD dismiss];
        if (QHCDict(responseDict)) {
            NSMutableArray *moreArr = [QHCTopicModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            [weakSelf.topicModelArr addObjectsFromArray:moreArr];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *errorMess) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
    
}

- (NSString *)judgeNew
{
    if ([self.parentViewController isKindOfClass:[QHCNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}

#pragma mark ----- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicModelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHCTopicCell *cell = [QHCTopicCell cellWith:tableView];
    cell.topicModel = self.topicModelArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.topicModelArr[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHCCommentViewController *commentVc = [[QHCCommentViewController alloc] init];
    commentVc.topicModel = self.topicModelArr[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

@end
