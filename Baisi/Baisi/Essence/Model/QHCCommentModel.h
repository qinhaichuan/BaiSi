//
//  QHCCommentModel.h
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCCommentModel : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 */
@property (nonatomic, copy) NSString *sex;

/** id */
@property (nonatomic, copy) NSString *id;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
@end
