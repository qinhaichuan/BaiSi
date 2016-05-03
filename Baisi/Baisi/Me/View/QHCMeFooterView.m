//
//  QHCMeFooterView.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCMeFooterView.h"
#import "QHCSquareModel.h"
#import "QHCSquareButton.h"
#import "QHCTabBarVC.h"
#import "QHCWebView.h"
@interface QHCMeFooterView()

@property(nonatomic, strong) NSArray *squareArr;

@end

@implementation QHCMeFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [SVProgressHUD showWithStatus:@"数据请求中..."];
        __weak typeof(self) weakSelf = self;
        [QHCHttpManger getDataWithDict:params success:^(NSDictionary *responseDict) {
//            QHCLog(@"-----======%@", responseDict);
            [SVProgressHUD dismiss];
            if (responseDict) {
                weakSelf.squareArr = [QHCSquareModel mj_objectArrayWithKeyValuesArray:responseDict[@"square_list"]];
                
//                QHCLog(@"-----======%@", _squareArr);
                [weakSelf creatBtn:weakSelf.squareArr];
                
            }
            
        } failure:^(NSError *errorMess) {
            [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
            
        }];
        
    }
    return self;
}


- (void)creatBtn:(NSArray *)squareArr
{
    NSInteger columns = 4;
    
    CGFloat btnW = screenW/4;
    CGFloat btnH = btnW;
    
    for (int i = 0; i < squareArr.count; i++) {
        
        QHCSquareButton *btn = [QHCSquareButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(squareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        CGFloat btnX = i % columns * btnW;
        CGFloat btnY = i / columns * btnH;
    
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.squareModel = squareArr[i];

    }
    self.height = CGRectGetMaxY(self.subviews.lastObject.frame);
    
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    
}

- (void)squareBtnClick:(QHCSquareButton *)squareBtn
{
    NSString *url = squareBtn.squareModel.url;
    
    if ([url hasPrefix:@"mod://"]) {
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            // 跳转到check控制器
            QHCLogFunc
        }else if ([url hasSuffix:@"App_To_SearchUser"]){
            
            // 跳转到另一控制器
            QHCLogFunc
        }
        
    }else if ([url hasPrefix:@"http://"]){
    
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBar.selectedViewController;
        
        QHCWebView *webV = [[QHCWebView alloc] init];
        webV.navigationItem.title = squareBtn.squareModel.name;
        webV.url = url;
        [nav pushViewController:webV animated:YES];
    }
    

}





@end
