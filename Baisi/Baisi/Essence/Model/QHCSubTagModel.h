//
//  QHCSubTagModel.h
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCSubTagModel : NSObject

/*
 "image_list" = "http://img.spriteapp.cn/ugc/2015/10/15/134220_27775.jpg";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 66014;
 "theme_id" = 473;
 "theme_name" = "\U793e\U4f1a\U65b0\U95fb";
 */

@property(nonatomic, copy) NSString *theme_name;
@property(nonatomic, copy) NSString *image_list;
@property(nonatomic, assign) NSInteger sub_number;

@end
