//
//  QHCRightCell.m
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCRightCell.h"
#import "QHCRecommendUserModel.h"
@interface QHCRightCell()
/*

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, assign) NSInteger fans_count;

@property (nonatomic, copy) NSString *header;
 */
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *fansLbl;
@property(nonatomic, weak) UILabel *headerLbl;
@property(nonatomic, weak) UIButton *subscribeBtn;

@end

@implementation QHCRightCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"rightCell";
    QHCRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self.contentView addSubview:iconView];
        
        UILabel *headerLbl = [[UILabel alloc] init];
        self.headerLbl = headerLbl;
        headerLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:headerLbl];
        
        UILabel *fansLbl = [[UILabel alloc] init];
        self.fansLbl = fansLbl;
        fansLbl.font = [UIFont systemFontOfSize:14];
        fansLbl.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:fansLbl];
        
        UIButton *subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.subscribeBtn = subscribeBtn;
        [subscribeBtn setTitle:@"+订阅" forState:UIControlStateNormal];
        subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [subscribeBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [subscribeBtn.layer setBorderWidth:1.0];
//        [subscribeBtn.layer setCornerRadius:5.0];
        [subscribeBtn.titleLabel sizeToFit];
        [subscribeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.contentView addSubview:subscribeBtn];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(MarginX, MarginX, 50*QHCScreen_WRtio, 50*QHCScreen_HRtio);

    CGSize headerSize = [self.headerLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.headerLbl.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + MarginX, self.iconView.y, headerSize.width, headerSize.height);
    
    CGSize fansSize = [self.fansLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.fansLbl.frame = CGRectMake(self.headerLbl.x, CGRectGetMaxY(self.iconView.frame) - fansSize.height, fansSize.width, fansSize.height);
    
    self.subscribeBtn.frame = CGRectMake(self.width - 50*QHCScreen_WRtio - MarginX, 0, 50*QHCScreen_WRtio, 25*QHCScreen_HRtio);
    self.subscribeBtn.centerY = self.iconView.centerY;
    
}

- (void)setRecommendUserModel:(QHCRecommendUserModel *)recommendUserModel
{
    _recommendUserModel = recommendUserModel;
    
    [self.iconView setCircleImageView:recommendUserModel.header];
    self.headerLbl.text = recommendUserModel.screen_name;
    
    NSString *fansText = nil;
    if (recommendUserModel.fans_count >= 10000) {
        fansText = [NSString stringWithFormat:@"%.2f万人关注", recommendUserModel.fans_count / 10000.0f];
    }else{
        fansText = [NSString stringWithFormat:@"%zd人关注", recommendUserModel.fans_count];
    }
    self.fansLbl.text = fansText;
    
    

}


@end
