//
//  QHCUserModel.h
//  Baisi
//
//  Created by QHC on 5/11/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCUserModel : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
@end
