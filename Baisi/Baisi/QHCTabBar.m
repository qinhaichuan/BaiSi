//
//  QHCTabBar.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTabBar.h"

@interface QHCTabBar()

@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation QHCTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UIButton *publishBtn = [[UIButton alloc] init];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishBtn sizeToFit];
        self.publishBtn = publishBtn;
        [self addSubview:publishBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishBtn.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
    
    CGFloat tabBarW = self.frame.size.width / 5;
    CGFloat tabBarH = self.frame.size.height;
    CGFloat tabBarY = 0;
    
    int index = 0;
    for (UIView *tabBarButton in self.subviews) {
        
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat tabBarX = index * tabBarW;
        if (index >= 2) {
            
            tabBarX += tabBarW;
        }
        
        tabBarButton.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
        index ++;
        
    }
}


@end
