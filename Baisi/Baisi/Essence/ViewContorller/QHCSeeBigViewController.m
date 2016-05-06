//
//  QHCSeeBigViewController.m
//  Baisi
//
//  Created by QHC on 5/6/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSeeBigViewController.h"
#import "QHCTopicModel.h"


@interface QHCSeeBigViewController()<UIScrollViewDelegate>

@property(nonatomic, weak) UIImageView *imageView;

@end

@implementation QHCSeeBigViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = QHCRandom_Color
    [self creatBtn];
    [self creatScrollView];
}

- (void)creatBtn
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(MarginX, 64*QHCScreen_HRtio, 35*QHCScreen_WRtio, 35*QHCScreen_HRtio);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundColor:[UIColor lightGrayColor]];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    saveBtn.frame = CGRectMake(screenW - MarginX - 70*QHCScreen_WRtio, screenH - 75*QHCScreen_HRtio, 70*QHCScreen_WRtio, 30*QHCScreen_HRtio);
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    
}

- (void)creatScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.image0]];
    imageView.width = scrollView.width;
    imageView.height = self.topicModel.height * imageView.width / self.topicModel.width;
    imageView.x = 0;
    if (imageView.height >= screenH) {
        imageView.y = 0;
    }else{
        imageView.centerY = screenH/2;
    }
    
    [scrollView addSubview:imageView];
    
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    // 缩放比例
    CGFloat maxScale = self.topicModel.height / imageView.height;
    if (maxScale >= 1) {
        scrollView.maximumZoomScale = maxScale;
    }
    
}


- (void)saveClick
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ----- UIScrollViewDelegate
/**
 *  返回一个scrollView内部的子控件进行缩放
 */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;

}

@end
