//
//  QHCSubTagCell.m
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSubTagCell.h"
#import "QHCSubTagModel.h"
@interface QHCSubTagCell()

@property(nonatomic, weak) UILabel *themNameLbl;
@property(nonatomic, weak) UIImageView *imageListImageV;
@property(nonatomic, weak) UILabel *subNumLbl;
@property(nonatomic, weak) UIButton *subscribeBtn;

@end
@implementation QHCSubTagCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"subTag";
    QHCSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[QHCSubTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        UILabel *themNameLbl = [[UILabel alloc] init];
        themNameLbl.font = [UIFont systemFontOfSize:15];
        self.themNameLbl = themNameLbl;
        [self.contentView addSubview:themNameLbl];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageListImageV = imageV;
        [self.contentView addSubview:imageV];
        
        UILabel *subNumLbl = [[UILabel alloc] init];
        subNumLbl.font = [UIFont systemFontOfSize:15];
        self.subNumLbl = subNumLbl;
        [self.contentView addSubview:subNumLbl];
        
        UIButton *subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [subscribeBtn setTitle:@"+订阅" forState:UIControlStateNormal];
        [subscribeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [subscribeBtn.layer setCornerRadius:5.0];
        [subscribeBtn.layer setBorderWidth:1.0];
        [subscribeBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        self.subscribeBtn = subscribeBtn;
        [self.contentView addSubview:subscribeBtn];
        
        
        
    }

    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageX = 30*QHCScreen_WRtio;
    CGFloat imageY = 10*QHCScreen_HRtio;
    CGFloat imageW = 60*QHCScreen_WRtio;
    CGFloat imageH = 60*QHCScreen_HRtio;
    self.imageListImageV.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat themNameX = imageX + imageW + 10*QHCScreen_WRtio;
    CGFloat themNameY = imageY;
    CGSize themSize = [self.themNameLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGFloat themNameW = themSize.width;
    CGFloat themNameH = themSize.height;
    self.themNameLbl.frame = CGRectMake(themNameX, themNameY, themNameW, themNameH);
    
    CGSize subNumSize = [self.subNumLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGFloat subNumX = themNameX;
    CGFloat subNumY = imageY + imageH - subNumSize.height;
    CGFloat subNumW = subNumSize.width;
    CGFloat subNumH = subNumSize.height;
    self.subNumLbl.frame = CGRectMake(subNumX, subNumY, subNumW, subNumH);
    
    CGSize subBtnSize = [self.subscribeBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGFloat subBtnX = screenW - subBtnSize.width - 30*QHCScreen_WRtio;
    CGFloat subBtnY = self.frame.size.height/2 - subBtnSize.height/2;
    CGFloat subBtnW = subBtnSize.width;
    CGFloat subBtnH = subBtnSize.height;
    self.subscribeBtn.frame = CGRectMake(subBtnX, subBtnY, subBtnW, subBtnH);
    

}

-(void)setSubTagModel:(QHCSubTagModel *)subTagModel
{
    _subTagModel = subTagModel;
    self.themNameLbl.text = subTagModel.theme_name;
    [self.imageListImageV sd_setImageWithURL:[NSURL URLWithString:subTagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    if (subTagModel.sub_number > 10000) {
        self.subNumLbl.text = [NSString stringWithFormat:@"%.1f万人订阅", subTagModel.sub_number/1000.0];
    }else{
        self.subNumLbl.text = [NSString stringWithFormat:@"%ld人订阅", subTagModel.sub_number];
    }
}












- (void)awakeFromNib {


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
