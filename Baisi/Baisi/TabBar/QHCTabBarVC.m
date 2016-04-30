//
//  QHCTabBarVC.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTabBarVC.h"
#import "QHCTabBar.h"
#import "QHCEssenceViewController.h"
#import "QHCNewViewController.h"
#import "QHCFriendTrendsViewController.h"
#import "QHCMeViewController.h"
#import "QHCNavigationViewController.h"
@interface QHCTabBarVC ()


@end

@implementation QHCTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setValue:[[QHCTabBar alloc] initWithFrame:self.tabBar.bounds] forKey:@"tabBar"];
    
    [self setupItemAttribute];
    [self setChildVC];
}

- (void)setupItemAttribute
{
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];

    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UIBarButtonItem *items = [UIBarButtonItem appearance];
    [items setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)setChildVC
{
    [self setOneChildVc:[[QHCNavigationViewController alloc] initWithRootViewController:[[QHCEssenceViewController alloc] init]] Title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setOneChildVc:[[QHCNavigationViewController alloc] initWithRootViewController:[[QHCFriendTrendsViewController alloc] init]] Title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setOneChildVc:[[QHCNavigationViewController alloc] initWithRootViewController:[[QHCNewViewController alloc] init]] Title:@"新贴" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setOneChildVc:[[QHCNavigationViewController alloc] initWithRootViewController:[[QHCMeViewController alloc] init]] Title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    

}

- (void)setOneChildVc:(UIViewController *)VC Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    VC.view.backgroundColor = QHCRandom_Color;
    [self addChildViewController:VC];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
