//
//  QHCLeftCell.m
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCLeftCell.h"
#import "QHCRecommendModel.h"

@interface QHCLeftCell()

@property(nonatomic, weak) UILabel *tagLbl;
@property(nonatomic, weak) UIView *tagView;

@end

@implementation QHCLeftCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"leftCell";
    QHCLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *tagView = [[UIView alloc] init];
        self.tagView = tagView;
        tagView.backgroundColor = QHCBgColor
        [self.contentView addSubview:tagView];
        
        UILabel *tagLbl = [[UILabel alloc] init];
        self.tagLbl = tagLbl;
        tagLbl.textAlignment = NSTextAlignmentCenter;
        tagLbl.backgroundColor = QHCBgColor
        tagLbl.textColor = [UIColor whiteColor];
        tagLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:tagLbl];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tagView.frame = CGRectMake(0, 0, 10*QHCScreen_WRtio, self.height-2);
    self.tagLbl.frame = CGRectMake(10*QHCScreen_WRtio, 0, self.width - 10*QHCScreen_WRtio, self.height-2);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.tagView.backgroundColor = [UIColor yellowColor];
        self.tagLbl.textColor = [UIColor yellowColor];
    }else{
        self.tagView.backgroundColor = QHCBgColor
        self.tagLbl.textColor = [UIColor whiteColor];
    }

}

- (void)setRecommendModel:(QHCRecommendModel *)recommendModel
{
    _recommendModel = recommendModel;
    
    self.tagLbl.text = recommendModel.name;

}

//- (void)setFrame:(CGRect)frame
//{
//    
//    frame.origin.y += 1;
//    frame.size.height -= 1;
//    
//    [super setFrame:frame];
//}


@end
