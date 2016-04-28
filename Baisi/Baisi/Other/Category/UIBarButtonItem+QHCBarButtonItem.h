//
//  UIBarButtonItem+QHCBarButtonItem.h
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QHCBarButtonItem)

+ (instancetype)barBtuttonItemImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
