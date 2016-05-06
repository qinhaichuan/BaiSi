
//
//  QHCPictureView.m
//  Baisi
//
//  Created by QHC on 5/5/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCPictureView.h"
#import "QHCTopicModel.h"
@interface QHCPictureView()

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UIButton *seeBigBtn;
@property(nonatomic, weak) UIImageView *gifView;

@end

@implementation QHCPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.iconView = iconView;
//        iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:iconView];
        
        UIImage *imag = [UIImage imageNamed:@"common-gif"];
        UIImageView *gifView = [[UIImageView alloc] init];
        self.gifView = gifView;
        gifView.image = imag;
        [self addSubview:gifView];
        
        UIButton *seeBigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.seeBigBtn = seeBigBtn;
        [seeBigBtn setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
        [seeBigBtn setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background"] forState:UIControlStateNormal];
        [seeBigBtn setTitle:@"点击查看大图" forState:UIControlStateNormal];
        seeBigBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.iconView addSubview:seeBigBtn];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
    self.gifView.frame = CGRectMake(0, 0, 64*QHCScreen_WRtio, 64*QHCScreen_HRtio);
    self.seeBigBtn.frame = CGRectMake(0, self.height - 43*QHCScreen_HRtio, self.width, 43*QHCScreen_HRtio);
    
}

-(void)setTopic:(QHCTopicModel *)topic
{
    _topic = topic;
    
    QHCLog(@"==++++++====%i", topic.is_gif);
    
    [self.iconView setOrigianlImageView:topic.image0];
    self.gifView.hidden = !topic.is_gif;
    self.seeBigBtn.hidden = !topic.isBigPicture;
    
    if (topic.isBigPicture) {
        
        self.iconView.contentMode = UIViewContentModeTop;
        self.iconView.clipsToBounds = YES;
    }else{
        self.iconView.contentMode = UIViewContentModeScaleToFill;
        self.iconView.clipsToBounds = NO;
    }
    
}


@end
