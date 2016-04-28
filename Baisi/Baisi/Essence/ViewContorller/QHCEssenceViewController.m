//
//  QHCEssenceViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCEssenceViewController.h"

@interface QHCEssenceViewController ()

@end

@implementation QHCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtuttonItemImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainSubClick)];

}

- (void)mainSubClick
{
    QHCLogFunc

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
