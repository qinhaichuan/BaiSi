//
//  QHCSeeBigViewController.m
//  Baisi
//
//  Created by QHC on 5/6/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSeeBigViewController.h"
#import "QHCTopicModel.h"
#import <Photos/Photos.h>

@interface QHCSeeBigViewController()<UIScrollViewDelegate>

@property(nonatomic, weak) UIImageView *imageView;

@end

@implementation QHCSeeBigViewController

static NSString * const QHCPhotoName = @"这就是要创建的相册";

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

/*
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
*/

/*
 PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
 PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
 PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
 PHAuthorizationStatusAuthorized
 */

- (void)saveClick
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {     // 用户还未做出选择
        QHCLog(@"用户还没有做出选择");
        [self saveImageToPhoto];
    }else if (status == PHAuthorizationStatusRestricted) {      // 家长控制
        QHCLog(@"家长控制 - 不允许访问");
    }else if (status == PHAuthorizationStatusAuthorized) {       // 用户同意访问相册
        QHCLog(@"用户允许访问相册");
        [self saveImageToPhoto];
    }else if (status == PHAuthorizationStatusDenied) {      // 用户拒绝访问相册
        QHCLog(@"用户拒绝当前应用访问相册 - 提醒用户打开访问开关");
    }
    
}

- (void)saveImageToPhoto
{
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件, 比如一张图片
     
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetID = nil;
    
    // 存储图片到相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            QHCLog(@"照片保存到相册失败");
            return;
        }
        
        QHCLog(@"保存到相册成功");
        
        // 获得相册对象
        PHAssetCollection *collection = [self assetCollection];
        
        // 将相机胶卷中的相册添加到创建的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标识获取照片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            // 添加到相册
            [request addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                QHCLog(@"获取照片失败");
                return;
            }
            
            QHCLog(@"获取照片成功");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [SVProgressHUD showSuccessWithStatus:@"保存照片成功"];
                
            }];
            
        }];
        
    }];

}

/*
 *  获取相册, 如没, 就创建一个新的
 */
- (PHAssetCollection *)assetCollection
{
    // 获得以前创建过的相册
    PHFetchResult<PHAssetCollection *> *assetCollecton = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in assetCollecton) {
        if ([collection.localizedTitle isEqualToString:QHCPhotoName]) {
            return collection;
        }
    }
    
    // 如果不存在就创建一个新的相册
    __block NSString *collectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        collectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:QHCPhotoName].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:nil];
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].firstObject;
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
