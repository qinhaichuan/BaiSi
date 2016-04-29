//
//  QHCButton.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCButton.h"

@implementation QHCButton


//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self == [super initWithFrame:frame]) {
//        self.frame = frame;
//        
//    }
//    return self;
//}

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage
{
    if (self == [super init]) {
        //    [btn setContentEdgeInsets:UIEdgeInsetsMake(100, 20, 20, 20)];
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(100*QHCScreen_HRtio, 0, 0, 0)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    
    return self;
}

@end
