//
//  QHCCommentCell.m
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCCommentCell.h"
#import "QHCCommentModel.h"
#import "QHCUserModel.h"

@interface QHCCommentCell()

@property(nonatomic, weak) UIImageView *profileImageV;
@property(nonatomic, weak) UILabel *userNameLbl;
@property(nonatomic, weak) UIImageView *sexImageV;
@property(nonatomic, weak) UILabel *contentLbl;
@property(nonatomic, weak) UILabel *likeCountLbl;
@property(nonatomic, weak) UIButton *likeClickBtn;

@end

@implementation QHCCommentCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"commentCell";
    QHCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.backgroundColor = QHCBgColor
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *profileImageV = [[UIImageView alloc] init];
        self.profileImageV = profileImageV;
        [self.contentView addSubview:profileImageV];
        
        UIImageView *sexImageV = [[UIImageView alloc] init];
        self.sexImageV = sexImageV;
        [self.contentView addSubview:sexImageV];
        
        UILabel *userNameLbl = [[UILabel alloc] init];
        self.userNameLbl = userNameLbl;
        userNameLbl.font = [UIFont systemFontOfSize:14];
        userNameLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:userNameLbl];
        
        UIButton *likeClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeClickBtn = likeClickBtn;
        [likeClickBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButton"] forState:UIControlStateNormal];
        [likeClickBtn setBackgroundImage:[UIImage imageNamed:@"commentLikeButtonClick"] forState:UIControlStateHighlighted];
//        [likeClickBtn setImage:[UIImage imageNamed:@"commentLikeButton"] forState:UIControlStateNormal];
//        [likeClickBtn setImage:[UIImage imageNamed:@"commentLikeButtonClick"] forState:UIControlStateHighlighted];
//        likeClickBtn.imageView.frame = likeClickBtn.bounds;
//        [likeClickBtn sizeToFit];
        [self.contentView addSubview:likeClickBtn];
        
        UILabel *likeCountLbl = [[UILabel alloc] init];
        self.likeCountLbl = likeCountLbl;
        likeCountLbl.font = [UIFont systemFontOfSize:14];
        likeCountLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:likeCountLbl];
        
        UILabel *contentLbl = [[UILabel alloc] init];
        self.contentLbl = contentLbl;
        contentLbl.numberOfLines = 0;
        contentLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:contentLbl];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.profileImageV.frame = self.commentModel.profileImageFrame;
    self.sexImageV.frame = self.commentModel.sexImageFrame;
    self.userNameLbl.frame = self.commentModel.userNameLblFrame;
    self.likeClickBtn.frame = self.commentModel.likeBtnFrame;
    self.likeCountLbl.frame = self.commentModel.likeCountLblFrame;
    self.contentLbl.frame = self.commentModel.contentLblFrame;

    
}

- (void)setCommentModel:(QHCCommentModel *)commentModel
{
    _commentModel = commentModel;
    
    [self.profileImageV setCircleImageView:commentModel.user.profile_image];
    NSString *imageName = [commentModel.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexImageV.image = [UIImage imageNamed:imageName];
    self.likeCountLbl.text = [NSString stringWithFormat:@"%zd", commentModel.like_count];
    self.contentLbl.text = commentModel.content;
    self.userNameLbl.text = commentModel.user.username;
}

@end
