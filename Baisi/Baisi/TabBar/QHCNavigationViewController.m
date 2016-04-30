//
//  QHCNavigationViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCNavigationViewController.h"

@interface QHCNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation QHCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 滑动返回手势
    self.interactivePopGestureRecognizer.delegate = self;
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 栈顶控制器(根控制器)为0
    // 拦截push出去的控制器
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn sizeToFit];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        
    }
    [super pushViewController:viewController animated:YES];
}

- (void)backClick
{
    [self popViewControllerAnimated:YES];

}

#pragma mark ----- UIGestureRecognizerDelegate
/**
 *  决定pop手势是否有效
 *  @return YES为有效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.viewControllers.count > 1);

}

@end
