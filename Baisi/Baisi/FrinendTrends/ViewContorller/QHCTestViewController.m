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
#import "QHCRecommendUserModel.h"
@interface QHCTestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView *leftView;
@property(nonatomic, weak) UITableView *rightView;
@property(nonatomic, strong) NSMutableArray<QHCRecommendModel *> *recommendModelArr;
@property(nonatomic, strong) NSMutableArray<QHCRecommendUserModel *> *recommendUserArr;

@end

@implementation QHCTestViewController

- (NSMutableArray *)recommendModelArr
{
    if (!_recommendModelArr) {
        _recommendModelArr = [NSMutableArray array];
    }
    return _recommendModelArr;
}

- (NSMutableArray *)recommendUserArr
{
    if (!_recommendUserArr) {
        _recommendUserArr = [NSMutableArray array];
    }
    return _recommendUserArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Test";
    self.view.backgroundColor = QHCBgColor;
    [self setTableView];
    [self getDate];
    self.rightView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRightDate)];
    [self.rightView.mj_header beginRefreshing];
    self.rightView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRightMoreDate)];
}

- (void)setTableView
{
    UITableView *leftView = [[UITableView alloc] init];
    self.leftView = leftView;
    leftView.delegate = self;
    leftView.dataSource = self;
    leftView.backgroundColor = QHCBgColor
    leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftView.frame = CGRectMake(0, 0, 70*QHCScreen_WRtio, self.view.height);
//    UIEdgeInsets insets1 = UIEdgeInsetsMake(64*QHCScreen_HRtio, 0, 0, 0);
//    leftView.scrollIndicatorInsets = insets1;
//    leftView.contentInset = insets;
    [self.view addSubview:leftView];
    
    UITableView *rightView = [[UITableView alloc] init];
    self.rightView = rightView;
    rightView.delegate = self;
    rightView.dataSource = self;
    rightView.rowHeight = 70*QHCScreen_HRtio;
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
       
        [weakSelf.leftView reloadData];
       
        // 默认选中第一行
        [weakSelf.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

        [weakSelf.rightView.mj_header beginRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *errorMess) {
        [SVProgressHUD showWithStatus:@"加载失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];

}

- (void)loadRightDate
{
    QHCRecommendModel *recommendM = self.recommendModelArr[self.leftView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = recommendM.id;

    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        
        if (QHCDict(responseDict)) {
            
            weakSelf.recommendUserArr = [QHCRecommendUserModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            
            recommendM.page = 1;
            recommendM.total = [responseDict[@"total"] integerValue];
        }
        
        [SVProgressHUD dismiss];
        [weakSelf.rightView.mj_header endRefreshing];
        [weakSelf.rightView reloadData];
        
        // 总结页数和当前请求的一样, 不用再刷新, 因为没了
        if (weakSelf.recommendUserArr.count == recommendM.total) {
            // 提示没有更多数据
            [weakSelf.rightView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.rightView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSError *errorMess) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [weakSelf.rightView.mj_header endRefreshing];
        
    }];
}

- (void)loadRightMoreDate
{
    // 当前选中的类型模型
    QHCRecommendModel *recommendM = self.recommendModelArr[self.leftView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = recommendM.id;
    NSInteger page = recommendM.page + 1;
    params[@"page"] = @(page);
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        
        if (QHCDict(responseDict)) {
            
            NSArray *arr = [QHCRecommendUserModel mj_objectArrayWithKeyValuesArray:responseDict[@"list"]];
            [weakSelf.recommendUserArr addObjectsFromArray:arr];
            
            recommendM.page = page;
            recommendM.total = [responseDict[@"total"] integerValue];
            
        }
        
        [weakSelf.rightView reloadData];
        [SVProgressHUD dismiss];
        
        if (weakSelf.recommendUserArr.count == recommendM.total) {
            [weakSelf.rightView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.rightView.mj_footer.hidden = YES;
        }else{
            [weakSelf.rightView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *errorMess) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

#pragma mark ----- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftView) {
        return self.recommendModelArr.count;
    }else{
        return self.recommendUserArr.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftView) {
        QHCLeftCell *cell = [QHCLeftCell cellWithTableView:tableView];
        cell.recommendModel = self.recommendModelArr[indexPath.row];
        return cell;
    }else{
        QHCRightCell *cell = [QHCRightCell cellWithTableView:tableView];
        cell.recommendUserModel = self.recommendUserArr[indexPath.row];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftView) {
        [self.rightView.mj_header beginRefreshing];
    }

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
