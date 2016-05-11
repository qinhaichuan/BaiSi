//
//  QHCCommentModel.h
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QHCUserModel;
@interface QHCCommentModel : NSObject

@property(nonatomic, strong) QHCUserModel *user;

/** id */
@property (nonatomic, copy) NSString *id;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

@property(nonatomic, assign) CGFloat cellHeight;

@property(nonatomic, assign) CGRect profileImageFrame;
@property(nonatomic, assign) CGRect userNameLblFrame;
@property(nonatomic, assign) CGRect sexImageFrame;
@property(nonatomic, assign) CGRect contentLblFrame;
@property(nonatomic, assign) CGRect likeCountLblFrame;
@property(nonatomic, assign) CGRect likeBtnFrame;


@end
