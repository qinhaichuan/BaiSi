//
//  QHCSquareButton.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCSquareButton.h"
#import "QHCSquareModel.h"

@implementation QHCSquareButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, self.height*0.1, self.width/2, self.width/2);
    self.imageView.centerX = self.width/2;
    
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.width, self.height - CGRectGetMaxY(self.imageView.frame));

}

-(void)setSquareModel:(QHCSquareModel *)squareModel
{
    _squareModel = squareModel;
    
    [self setTitle:squareModel.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    

}

@end
