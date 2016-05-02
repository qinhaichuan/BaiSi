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
        
        UILabel *themNameLbl = [[UILabel alloc] init];
        self.themNameLbl = themNameLbl;
        [self.contentView addSubview:themNameLbl];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageListImageV = imageV;
        [self.contentView addSubview:imageV];
        
        UILabel *subNumLbl = [[UILabel alloc] init];
        self.subNumLbl = subNumLbl;
        [self.contentView addSubview:subNumLbl];
        
        UIButton *subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.subscribeBtn = subscribeBtn;
        [subscribeBtn setTitle:@"+订阅" forState:UIControlStateNormal];
        [subscribeBtn setTintColor:[UIColor redColor]];
        [self.contentView addSubview:subscribeBtn];
        
        
        
    }

    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    

}

-(void)setSubTagModel:(QHCSubTagModel *)subTagModel
{
    _subTagModel = subTagModel;
    self.themNameLbl.text = subTagModel.theme_name;
    self.imageListImageV.image = [UIImage imageNamed:subTagModel.image_list];
    self.subNumLbl.text = [NSString stringWithFormat:@"%ld", subTagModel.sub_number];

}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
