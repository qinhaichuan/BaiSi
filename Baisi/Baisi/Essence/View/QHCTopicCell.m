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
@property(nonatomic, weak) UIButton *moreBtn;
@property(nonatomic, weak) UIImageView *bottomLine;
@property(nonatomic, strong) NSMutableArray *btnLineArr;
@property(nonatomic, assign) QHCTopicType *topicTpye;

@end

@implementation QHCTopicCell

-(NSMutableArray *)btnLineArr
{
    if (!_btnLineArr) {
        _btnLineArr = [NSMutableArray array];
    }
    return _btnLineArr;
}

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
        nameLbl.font = [UIFont systemFontOfSize:14];
        nameLbl.textAlignment = NSTextAlignmentLeft;
        nameLbl.textColor = [UIColor lightGrayColor];
        self.nameLbl = nameLbl;
        [self.contentView addSubview:nameLbl];
        
        UILabel *creatAtLbl = [[UILabel alloc] init];
        creatAtLbl.font = [UIFont systemFontOfSize:12];
        nameLbl.textAlignment = NSTextAlignmentLeft;
        creatAtLbl.textColor = [UIColor lightGrayColor];
        self.createdAtLbl = creatAtLbl;
        [self.contentView addSubview:creatAtLbl];
        
        UILabel *textLbl = [[UILabel alloc] init];
        self.textLbl = textLbl;
        textLbl.numberOfLines = 0;
        textLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:textLbl];
        
        
        UIButton *dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dingBtn = dingBtn;
        [self setBottomBtn:dingBtn title:@"顶" image:@"mainCellDing" highImage:@"mainCellDingClick" target:self action:@selector(dingClick)];
        
        
        UIButton *caiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.caiBtn = caiBtn;
        [self setBottomBtn:caiBtn title:@"踩" image:@"mainCellCai" highImage:@"mainCellCaiClick" target:self action:@selector(caiClick)];

        
        UIButton *repostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.repostBtn = repostBtn;
        [self setBottomBtn:repostBtn title:@"分享" image:@"mainCellShare" highImage:@"mainCellShareClick" target:self action:@selector(repostClick)];

        
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn = commentBtn;
        [self setBottomBtn:commentBtn title:@"评论" image:@"mainCellComment" highImage:@"mainCellCommentClick" target:self action:@selector(commentClick)];

        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        self.bottomLine  = bottomLine;
        [self.contentView addSubview:bottomLine];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *btnLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-button-line"]];
            btnLine.tag = i;
            [self.btnLineArr addObject:btnLine];
            [self.contentView addSubview:btnLine];
        }
        
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreBtn = moreBtn;
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"cellmorebtnnormal"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"cellmorebtnclick"] forState:UIControlStateHighlighted];
        [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
        

        
    }
    return self;
}

- (void)setBottomBtn:(UIButton *)btn title:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [self.contentView addSubview:btn];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.profileImageView.frame = CGRectMake(10*QHCScreen_WRtio, 10*QHCScreen_HRtio, 35*QHCScreen_WRtio, 35*QHCScreen_HRtio);

    CGSize nameLblSize = [self.nameLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.nameLbl.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10.0*QHCScreen_WRtio, self.profileImageView.y, nameLblSize.width, nameLblSize.height);
    
    CGSize createdAtLblSize = [self.createdAtLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.createdAtLbl.frame = CGRectMake(self.nameLbl.x, CGRectGetMaxY(self.profileImageView.frame) - createdAtLblSize.height, createdAtLblSize.width, createdAtLblSize.height);
    
    self.moreBtn.frame = CGRectMake(self.width - 35*QHCScreen_WRtio - 10*QHCScreen_WRtio, 10*QHCScreen_HRtio, 35*QHCScreen_WRtio, 35*QHCScreen_HRtio);
    
    CGSize textLblSize = [self.textLbl.text boundingRectWithSize:CGSizeMake(self.width - 20*QHCScreen_WRtio, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.textLbl.frame = CGRectMake(10*QHCScreen_WRtio, CGRectGetMaxY(self.profileImageView.frame) + 10.0*QHCScreen_HRtio, textLblSize.width, textLblSize.height);
    
    
    
    CGFloat btnW = self.width/4;
    CGFloat btnH = 35*QHCScreen_HRtio;
    CGFloat btnY = CGRectGetMaxY(self.textLbl.frame) + 10*QHCScreen_HRtio;
    
    self.bottomLine.frame = CGRectMake(0, btnY + 1.0*QHCScreen_HRtio, self.width, 1.0*QHCScreen_HRtio);
    
    self.dingBtn.frame = CGRectMake(0, btnY, btnW, btnH);
    self.caiBtn.frame = CGRectMake(CGRectGetMaxX(self.dingBtn.frame), btnY, btnW, btnH);
    self.repostBtn.frame = CGRectMake(CGRectGetMaxX(self.caiBtn.frame), btnY, btnW, btnH);
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.repostBtn.frame), btnY, btnW, btnH);
    
    for (int i = 0; i < self.btnLineArr.count; i++) {
        
        UIImageView *btnLineV = self.btnLineArr[i];
        btnLineV.frame = CGRectMake((i + 1) * btnW, btnY + 1.0*QHCScreen_HRtio, 1.0*QHCScreen_WRtio, btnH - 2.0*QHCScreen_HRtio);
        
    }
    
    self.height = CGRectGetMaxY(self.commentBtn.frame);

//    self.height = 100;

}

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y += 10*QHCScreen_HRtio;
//    frame.size.height -= 10*QHCScreen_HRtio;
//    [super setFrame:frame];
//
//}


-(void)setTopicModel:(QHCTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    [self.profileImageView setOrigianlImageView:topicModel.profile_image];
    self.nameLbl.text = topicModel.name;
    self.createdAtLbl.text = topicModel.created_at;
    self.textLbl.text = topicModel.text;
    
    [self setBtn:self.dingBtn titlle:@"顶" number:topicModel.ding];
    [self setBtn:self.caiBtn titlle:@"踩" number:topicModel.cai];
    [self setBtn:self.repostBtn titlle:@"分享" number:topicModel.repost];
    [self setBtn:self.commentBtn titlle:@"评论" number:topicModel.comment];

    
    
}

- (void)setBtn:(UIButton *)btn titlle:(NSString *)title number:(NSInteger)number
{
    if (number > 10000.0) {
        [btn setTitle:[NSString stringWithFormat:@"%.1f万", number/10000.0] forState:UIControlStateNormal];
    }else if(number > 1000.0){
        [btn setTitle:[NSString stringWithFormat:@"%.1f千", number/1000.0] forState:UIControlStateNormal];
    }else if (number == 0){
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }

}

- (void)moreClick
{
    QHCLogFunc
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QHCLogFunc
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        QHCLogFunc
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        QHCLogFunc
    }]];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)dingClick
{
    QHCLogFunc
}

- (void)caiClick
{
    QHCLogFunc
}

- (void)repostClick
{
    QHCLogFunc
}

- (void)commentClick
{
    QHCLogFunc
}


@end