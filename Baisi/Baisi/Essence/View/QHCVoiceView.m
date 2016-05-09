//
//  QHCVoiceView.m
//  Baisi
//
//  Created by QHC on 5/6/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCVoiceView.h"
#import "QHCSeeBigViewController.h"
#import "QHCTopicModel.h"

@interface QHCVoiceView()

@property(nonatomic, weak) UIImageView *imageV;
@property(nonatomic, weak) UIImageView *placeholderImageV;
@property(nonatomic, weak) UILabel *playCountLbl;
@property(nonatomic, weak) UILabel *videoTimeLbl;
@property(nonatomic, weak) UIButton *playBtn;

@end

@implementation QHCVoiceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = QHCBgColor;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageV = imageV;
//        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigClick)]];
        [self addSubview:imageV];
        
        UIImageView *placeholderImageV = [[UIImageView alloc] init];
        placeholderImageV.image = [UIImage imageNamed:@"imageBackground"];
        [self.imageV addSubview:placeholderImageV];
        
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playBtn = playBtn;
        playBtn.userInteractionEnabled = NO;
        [playBtn setBackgroundImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [self.imageV addSubview:playBtn];
        
        UILabel *playCountLbl = [[UILabel alloc] init];
        self.playCountLbl = playCountLbl;
        playCountLbl.numberOfLines = 1;
        playCountLbl.textColor = [UIColor whiteColor];
        playCountLbl.backgroundColor = [UIColor lightGrayColor];
        playCountLbl.font = [UIFont systemFontOfSize:15];
        [self.imageV addSubview:playCountLbl];
        
        UILabel *videoTimeLbl = [[UILabel alloc] init];
        self.videoTimeLbl = videoTimeLbl;
        videoTimeLbl.numberOfLines = 1;
        videoTimeLbl.textColor = [UIColor whiteColor];
        videoTimeLbl.backgroundColor = [UIColor lightGrayColor];
        videoTimeLbl.font = [UIFont systemFontOfSize:15];
        [self.imageV addSubview:videoTimeLbl];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = self.bounds;
    self.placeholderImageV.frame = CGRectMake(0, 20*QHCScreen_HRtio, self.imageV.width, 25*QHCScreen_HRtio);
    
    CGSize playCountSize = [self.playCountLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.playCountLbl.frame = CGRectMake(self.imageV.width - playCountSize.width, 0, playCountSize.width, playCountSize.height);
    
    CGSize videoTimeSize = [self.videoTimeLbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.videoTimeLbl.frame = CGRectMake(self.imageV.width - videoTimeSize.width, self.height - videoTimeSize.height, videoTimeSize.width, videoTimeSize.height);
    
    self.playBtn.width = 71*QHCScreen_WRtio;
    self.playBtn.height = 71*QHCScreen_HRtio;
    self.playBtn.center = self.imageV.center;
    
}

- (void)setTopicModel:(QHCTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:topicModel.image1]];
    self.playCountLbl.text = [NSString stringWithFormat:@"%zd播放", topicModel.playcount];
    
    NSInteger minute = topicModel.videotime / 60;
    NSInteger second = topicModel.videotime % 60;
    self.videoTimeLbl.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}


- (void)seeBigClick
{
    QHCSeeBigViewController *seeBigVc = [[QHCSeeBigViewController alloc] init];
    seeBigVc.topicModel = self.topicModel;
    [self.window.rootViewController presentViewController:seeBigVc animated:YES completion:nil];
    
}


@end
