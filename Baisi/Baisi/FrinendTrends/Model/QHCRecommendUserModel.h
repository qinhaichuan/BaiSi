//
//  QHCRecommendUserModel.h
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCRecommendUserModel : NSObject
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;



@end
