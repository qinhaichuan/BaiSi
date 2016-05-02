//
//  UIImage+QHCCircleImage.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "UIImage+QHCCircleImage.h"

@implementation UIImage (QHCCircleImage)

-(instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;    
}

+(instancetype)circleImage:(NSString *)imageName
{
    return [[self imageNamed:imageName] circleImage];
}

@end
