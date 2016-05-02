//
//  UIImageView+QHCCircleImageView.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "UIImageView+QHCCircleImageView.h"
#import "UIImage+QHCCircleImage.h"
@implementation UIImageView (QHCCircleImageView)


-(void)setCircleImageView:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
       self.image = [self.image circleImage];
    }];

}
-(void)setOrigianlImageView:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
