//
//  QHCTestViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTestViewController.h"
#import "QHCLeftTableView.h"
#import "QHCRightTableView.h"

@interface QHCTestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) QHCLeftTableView *leftView;
@property(nonatomic, weak) QHCRightTableView *rightView;

@end

@implementation QHCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Test";
    self.view.backgroundColor = QHCBgColor;
    [self setTableView];

}

- (void)setTableView
{
    QHCLeftTableView *leftView = [[QHCLeftTableView alloc] init];
    self.leftView = leftView;
    leftView.backgroundColor = QHCRandom_Color
    leftView.frame = CGRectMake(0, 0, 70*QHCScreen_WRtio, self.view.height);
    UIEdgeInsets insets = UIEdgeInsetsMake(64*QHCScreen_HRtio, 0, 0, 0);
    leftView.scrollIndicatorInsets = insets;
    leftView.contentInset = insets;
    [self.view addSubview:leftView];
    
    QHCRightTableView *rightView = [[QHCRightTableView alloc] init];
    self.rightView = rightView;
    rightView.backgroundColor = QHCRandom_Color
    rightView.frame = CGRectMake(70*QHCScreen_HRtio, 0, self.view.width - 70*QHCScreen_WRtio, self.view.height);
    rightView.scrollIndicatorInsets = UIEdgeInsetsMake(64*QHCScreen_HRtio, 0, 0, 0);
    [self.view addSubview:rightView];
    
    
}



#pragma mark ----- UITableViewDataSource







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
