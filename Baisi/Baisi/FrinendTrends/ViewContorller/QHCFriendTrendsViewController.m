//
//  QHCFriendTrendsViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCFriendTrendsViewController.h"
#import "QHCTestViewController.h"
@interface QHCFriendTrendsViewController ()

@end

@implementation QHCFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"关注";
    
    UIBarButtonItem *item = [UIBarButtonItem barBtuttonItemImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendTriendClick)];
    
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)friendTriendClick
{
    QHCTestViewController *testVc = [[QHCTestViewController alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
