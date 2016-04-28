//
//  QHCTestViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTestViewController.h"

@interface QHCTestViewController ()

@end

@implementation QHCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Test";
    self.view.backgroundColor = QHCRandom_Color
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [btn sizeToFit];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    
//    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    


}

//- (void)backClick
//{
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
