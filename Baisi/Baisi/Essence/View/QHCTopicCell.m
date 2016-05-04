//
//  QHCTopicCell.m
//  Baisi
//
//  Created by QHC on 5/4/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTopicCell.h"
#import "QHCTopicModel.h"

@interface QHCTopicCell()

@property(nonatomic, weak) UILabel *nameLbl;
@property(nonatomic, weak) UIImageView *profileImageView;
@property(nonatomic, weak) UILabel *textLbl;
@property(nonatomic, weak) UILabel *createdAtLbl;
@property(nonatomic, weak) UIButton *dingBtn;
@property(nonatomic, weak) UIButton *caiBtn;
@property(nonatomic, weak) UIButton *repostBtn;
@property(nonatomic, weak) UIButton *commentBtn;
@property(nonatomic, assign) QHCTopicType *topicTpye;

@end

@implementation QHCTopicCell

+(instancetype)cellWith:(UITableView *)tableView
{
    NSString *ID = @"topicCell";
    QHCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *profileImageV = [[UIImageView alloc] init];
        self.profileImageView = profileImageV;
        [self.contentView addSubview:profileImageV];
        
        UILabel *nameLbl = [[UILabel alloc] init];
        self.nameLbl = nameLbl;
        [self.contentView addSubview:nameLbl];
        
        UILabel *textLbl = [[UILabel alloc] init];
        self.textLbl = textLbl;
        [self.contentView addSubview:textLbl];
        
        UILabel *creatAtLbl = [[UILabel alloc] init];
        self.createdAtLbl = creatAtLbl;
        [self.contentView addSubview:creatAtLbl];
        
        UIButton *dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dingBtn = dingBtn;
        [self.contentView addSubview:dingBtn];
        
        UIButton *caiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.caiBtn = caiBtn;
        [self.contentView addSubview:caiBtn];
        
        UIButton *repostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.repostBtn = repostBtn;
        [self.contentView addSubview:repostBtn];
        
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn = commentBtn;
        [self.contentView addSubview:commentBtn];
        
//        UIButto
        
        
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}

-(void)setTopicModel:(QHCTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    
    

}

@end
