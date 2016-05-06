
//
//  QHCPictureView.m
//  Baisi
//
//  Created by QHC on 5/5/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCPictureView.h"
#import "QHCTopicModel.h"
#import "QHCSeeBigViewController.h"

@interface QHCPictureView()

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UIButton *seeBigBtn;
@property(nonatomic, weak) UIImageView *gifView;
@property(nonatomic, weak) UIImageView *placeImageV;
@property(nonatomic, weak) DALabeledCircularProgressView *daProgressV;
@end

@implementation QHCPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = QHCBgColor
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.iconView = iconView;
//        iconView.backgroundColor = [UIColor blueColor];
        iconView.userInteractionEnabled = YES;
        [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigClick)]];
        [self addSubview:iconView];
        
        UIImageView *placeImageV = [[UIImageView alloc] init];
        placeImageV.image = [UIImage imageNamed:@"post_placeholderImage"];
        self.placeImageV = placeImageV;
        [self addSubview:placeImageV];
        
        DALabeledCircularProgressView *daProgressV = [[DALabeledCircularProgressView alloc] init];
        self.daProgressV = daProgressV;
        daProgressV.progressLabel.textColor = [UIColor yellowColor];
        daProgressV.userInteractionEnabled = NO;
        daProgressV.roundedCorners = 5;
        [self addSubview:daProgressV];
        
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
        seeBigBtn.userInteractionEnabled = NO;
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
    self.placeImageV.frame = CGRectMake(0, 10*QHCScreen_HRtio, 145*QHCScreen_WRtio, 30*QHCScreen_HRtio);
    self.placeImageV.centerX = self.iconView.centerX;
    
    
    self.daProgressV.width = 100*QHCScreen_WRtio;
    self.daProgressV.height = self.daProgressV.width;
    self.daProgressV.center = CGPointMake(self.iconView.centerX, (self.iconView.height - self.topic.isBigPicture * self.seeBigBtn.height)/2);
}

-(void)setTopic:(QHCTopicModel *)topic
{
    _topic = topic;
    
//    QHCLog(@"==++++++====%i", topic.is_gif);
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.placeImageV.hidden = NO;
        self.daProgressV.hidden = NO;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.daProgressV.progress = progress;
        NSString *progressText = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        self.daProgressV.progressLabel.text = progressText;
        QHCLog(@"---%zd : %zd+++++%f===%@===%@", receivedSize, expectedSize, self.daProgressV.progress, progressText, self.daProgressV.progressLabel);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.placeImageV.hidden = YES;
        self.daProgressV.hidden = YES;
        
    }];
    
    
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

- (void)seeBigClick
{    
    if (self.iconView.image == nil) return;
    
    QHCSeeBigViewController *seeBigVc = [[QHCSeeBigViewController alloc] init];
    seeBigVc.topicModel = self.topic;
    [self.window.rootViewController presentViewController:seeBigVc animated:YES completion:nil];

}



@end
