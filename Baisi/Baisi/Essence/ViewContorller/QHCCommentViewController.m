//
//  QHCCommentViewController.m
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCCommentViewController.h"
#import "QHCCommentCell.h"
#import "QHCCommentModel.h"
#import "QHCTopicModel.h"
#import "QHCTopicCell.h"

@interface QHCCommentViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UIImageView *bottomView;
@property(nonatomic, strong) NSMutableArray<QHCCommentModel *> *hottestCommentArr;
@property(nonatomic, strong) NSMutableArray<QHCCommentModel *> *latestCommentArr;
@property(nonatomic, weak) UITableView *tableV;
/** 保存最热评论 */
@property (nonatomic, strong) id top_cmt;
@end

@implementation QHCCommentViewController

- (NSMutableArray *)hottestCommentArr
{
    if (!_hottestCommentArr) {
        _hottestCommentArr = [NSMutableArray array];
    }
    return _hottestCommentArr;
}

- (NSMutableArray *)latestCommentArr
{
    if (!_latestCommentArr) {
        _latestCommentArr = [NSMutableArray array];
    }
    return _latestCommentArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = QHCRandom_Color
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setView];
    [self setupHeaderview];
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDate)];
    self.tableV.mj_header.automaticallyChangeAlpha = YES;
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    self.tableV.mj_footer.automaticallyChangeAlpha = YES;
    
}

- (void)setView
{
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableV = tableV;
    tableV.delegate = self;
    tableV.dataSource = self;
//    tableV.rowHeight = UITableViewAutomaticDimension;
//    tableV.estimatedRowHeight = 200;
//    tableV.rowHeight = 100;
    [self.view addSubview:tableV];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenH - 44*QHCScreen_HRtio, screenW, 44*QHCScreen_HRtio)];
    self.bottomView = bottomView;
    bottomView.image = [UIImage imageNamed:@"comment-bar-bg"];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    
    UIImageView *commentVoiceV = [[UIImageView alloc] init];
    commentVoiceV.image = [UIImage imageNamed:@"comment-bar-voice"];
    commentVoiceV.frame = CGRectMake(2*QHCScreen_WRtio, 2*QHCScreen_HRtio, 40 * QHCScreen_HRtio, 40*QHCScreen_WRtio);
    [bottomView addSubview:commentVoiceV];
    
    UIImageView *commentAtV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment_bar_at_icon"]];
    commentAtV.frame = CGRectMake(bottomView.width - 44*QHCScreen_WRtio, 2, 40*QHCScreen_WRtio, 40*QHCScreen_HRtio);
    [bottomView addSubview:commentAtV];
    
    UITextField *commnetTextF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentVoiceV.frame) + 5*QHCScreen_WRtio, 5*QHCScreen_HRtio, bottomView.width - commentVoiceV.width - commentAtV.width - 16*QHCScreen_WRtio, bottomView.height - 10*QHCScreen_HRtio)];
    [commnetTextF setPlaceholder:@"写评论..."];
    commnetTextF.borderStyle = UITextBorderStyleRoundedRect;
    [bottomView addSubview:commnetTextF];
}

- (void)setupHeaderview
{
    if (self.topicModel.top_cmt) {
        self.top_cmt = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        self.topicModel.cellHeight = 0;
    }
    
    UIView *headerView = [[UIView alloc] init];
    headerView.userInteractionEnabled = YES;
    headerView.frame = CGRectMake(0, 0, screenW, self.topicModel.cellHeight);
    
    QHCTopicCell *cell = [[QHCTopicCell alloc] initWithFrame:headerView.bounds];
    cell.topicModel = self.topicModel;
    [headerView addSubview:cell];
    
    self.tableV.tableHeaderView.userInteractionEnabled = YES;
    self.tableV.tableHeaderView = headerView;
    
}

- (void)loadNewDate
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"hot"] = @"1";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.id;
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        [weakSelf.tableV.mj_header endRefreshing];
//        QHCLog(@"-----=========%@", responseDict);

        if (QHCDict(responseDict)) {
            weakSelf.latestCommentArr = [QHCCommentModel mj_objectArrayWithKeyValuesArray:responseDict[@"data"]];
            weakSelf.hottestCommentArr = [QHCCommentModel mj_objectArrayWithKeyValuesArray:responseDict[@"hot"]];
            
            NSInteger total = [responseDict[@"total"] integerValue];
            [weakSelf.tableV reloadData];
            
            if (weakSelf.latestCommentArr.count == total) {
                weakSelf.tableV.mj_header.hidden = YES;
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *errorMess) {
        [weakSelf.tableV.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

- (void)loadMoreDate
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.id;
    params[@"lastcid"] = self.latestCommentArr.lastObject.id;
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
        [weakSelf.tableV.mj_header endRefreshing];
        
        QHCLog(@"-----+++++%@", responseDict);
        
        if (QHCDict(responseDict)) {
            NSArray *arr = [QHCCommentModel mj_objectArrayWithKeyValuesArray:responseDict[@"data"]];
            [weakSelf.latestCommentArr addObjectsFromArray:arr];
            
            NSInteger total = [responseDict[@"total"] integerValue];
            [weakSelf.tableV reloadData];
            
            if (weakSelf.latestCommentArr.count == total) {
                weakSelf.tableV.mj_header.hidden = YES;
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *errorMess) {
        [weakSelf.tableV.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    


}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGRect keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    QHCLog(@"%f", keyBoardY.origin.y);
    self.bottomView.y = keyBoardY.origin.y - 44*QHCScreen_HRtio;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}




#pragma mark ----- UITableViewDateSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.hottestCommentArr.count && indexPath.section == 0) {
        return self.hottestCommentArr[indexPath.row].cellHeight;
    }else{
        return self.latestCommentArr[indexPath.row].cellHeight;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hottestCommentArr.count) return 2;
    if (self.latestCommentArr.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hottestCommentArr.count && section == 0) {
        return self.hottestCommentArr.count;
    }else{
        return self.latestCommentArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHCCommentCell *cell = [QHCCommentCell cellWithTableView:tableView];
    if (self.hottestCommentArr.count && indexPath.section == 0) {
        cell.commentModel = self.hottestCommentArr[indexPath.row];
    }else{
        cell.commentModel = self.latestCommentArr[indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.hottestCommentArr.count && section == 0) {
        return @"最热评论";
    }else{
        return @"最新评论";
    }
}




- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
    if (self.top_cmt) {
        self.topicModel.top_cmt = self.top_cmt;
        self.topicModel.cellHeight = 0;
    }
}

@end
