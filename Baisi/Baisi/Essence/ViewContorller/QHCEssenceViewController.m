//
//  QHCEssenceViewController.m
//  Baisi
//
//  Created by QHC on 4/28/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCEssenceViewController.h"
#import "QHCSubTagViewController.h"
#import "QHCAllViewController.h"
#import "QHCVideoViewController.h"
#import "QHCVoiceViewController.h"
#import "QHCPictureViewController.h"
#import "QHCWordsViewController.h"
#import "QHCBtn.h"
@interface QHCEssenceViewController ()<UIScrollViewDelegate>

@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic, strong) NSMutableArray *titleBtnArr;
@property(nonatomic, strong) QHCBtn *selectedBtn;
@property(nonatomic, weak) UIView *titleLine;

@end

@implementation QHCEssenceViewController

-(NSMutableArray *)titleBtnArr
{
    if (!_titleBtnArr) {
        _titleBtnArr = [NSMutableArray array];
    }
    return _titleBtnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    [self setChildVc];
    [self addScrollView];
    [self addTitleView];
    [self addChildVc];

}

- (void)setNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtuttonItemImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainSubClick)];

}

- (void)setChildVc
{
    QHCAllViewController *allVc = [[QHCAllViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    QHCVideoViewController *videoVc = [[QHCVideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    QHCVoiceViewController *voiceVc = [[QHCVoiceViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    QHCPictureViewController *pictureVc = [[QHCPictureViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    QHCWordsViewController *wordVc = [[QHCWordsViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];

}

- (void)addScrollView
{
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollerView;
    scrollerView.contentSize = CGSizeMake(screenW * self.childViewControllers.count, screenH);
    scrollerView.pagingEnabled = YES;
    scrollerView.delegate = self;
    [self.view addSubview:scrollerView];

}

- (void)addTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, screenW, 40);
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titleView];
    
    NSInteger count = self.childViewControllers.count;
    CGFloat titleLblW = screenW / count;
    CGFloat titleLblH = 40;
    for (NSInteger i = 0; i < count; i++) {
        
        QHCBtn *btn = [QHCBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        [self.titleBtnArr addObject:btn];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*titleLblW, 0, titleLblW, titleLblH);
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
 
    }
    
    QHCBtn *firstBtn = titleView.subviews.firstObject;
    [firstBtn.titleLabel sizeToFit];

    UIView *titleLine = [[UIView alloc] init];
    self.titleLine = titleLine;
    titleLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    titleLine.height = 1.0;
    titleLine.width = firstBtn.titleLabel.width;
    titleLine.y = titleView.height;
    titleLine.centerX = firstBtn.centerX;

    [titleView addSubview:titleLine];
    
    firstBtn.selected = YES;
    self.selectedBtn = firstBtn;

//    titleLine.centerX = firstBtn.centerX;
//    [firstBtn.titleLabel sizeToFit];
}

- (void)addChildVc
{
    UIScrollView *scrollView = self.scrollView;
    NSInteger index = scrollView.contentOffset.x / screenW;
    UIViewController *VC = self.childViewControllers[index];
    
    if (VC.isViewLoaded) return;
    VC.view.frame = scrollView.bounds;
    [scrollView addSubview:VC.view];
}

- (void)titleClick:(QHCBtn *)sender
{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;

    [UIView animateWithDuration:0.5 animations:^{
        
        [self.selectedBtn.titleLabel sizeToFit];
        self.titleLine.centerX = sender.centerX;
        
    }];

    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * screenW;
    [self.scrollView setContentOffset:offset animated:YES];
}


- (void)mainSubClick
{
    QHCSubTagViewController *subTagVc = [[QHCSubTagViewController alloc] init];
    subTagVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subTagVc animated:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    QHCBtn *btn = self.titleBtnArr[index];
    [self titleClick:btn];
    
    [self addChildVc];

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVc];

}

@end
