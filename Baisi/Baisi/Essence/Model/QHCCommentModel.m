//
//  QHCCommentModel.m
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCCommentModel.h"
#import "QHCUserModel.h"

@implementation QHCCommentModel

- (CGFloat)cellHeight
{
    CGFloat cellHeight = 0;
    
    self.profileImageFrame = CGRectMake(10.0*QHCScreen_WRtio, 10.0*QHCScreen_HRtio, 35.0*QHCScreen_WRtio, 35.0*QHCScreen_HRtio);
    self.sexImageFrame = CGRectMake(CGRectGetMaxX(self.profileImageFrame) + 10.0*QHCScreen_WRtio, 10.0*QHCScreen_HRtio, 20.0*QHCScreen_WRtio, 20*QHCScreen_HRtio);
    
    CGSize userNameSize = [self.user.username sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.userNameLblFrame = CGRectMake(CGRectGetMaxX(self.sexImageFrame), 10.0*QHCScreen_HRtio, userNameSize.width, userNameSize.height);
    
    cellHeight += 20.0*QHCScreen_HRtio + userNameSize.height;
    
    self.likeBtnFrame = CGRectMake(screenW - 40.0*QHCScreen_WRtio, 10.0*QHCScreen_HRtio, 30.0*QHCScreen_WRtio, 30.0*QHCScreen_HRtio);

    NSString *likeCountText = [NSString stringWithFormat:@"%zd", self.like_count];
    CGSize likeCountSize = [likeCountText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.likeCountLblFrame = CGRectMake(screenW - likeCountSize.width - 10.0*QHCScreen_WRtio, CGRectGetMaxY(self.likeBtnFrame), likeCountSize.width, likeCountSize.height);
    
    CGFloat contentWidth = screenW - CGRectGetMaxX(self.profileImageFrame) - 30*QHCScreen_WRtio - likeCountSize.width - self.likeBtnFrame.size.width;
    CGRect contentLblRect = [self.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.contentLblFrame = CGRectMake(CGRectGetMaxX(self.profileImageFrame) + 10.0*QHCScreen_WRtio, CGRectGetMaxY(self.userNameLblFrame) + 5.0*QHCScreen_HRtio, contentLblRect.size.width, contentLblRect.size.height);

    cellHeight += contentLblRect.size.height;
    return cellHeight;
}

@end
