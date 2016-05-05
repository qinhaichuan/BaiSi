
//
//  QHCPictureView.m
//  Baisi
//
//  Created by QHC on 5/5/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCPictureView.h"

@implementation QHCPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = QHCRandom_Color
        
    }
    return self;
}

@end
