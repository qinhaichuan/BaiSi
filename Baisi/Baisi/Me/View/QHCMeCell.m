//
//  QHCMeCell.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCMeCell.h"

@interface QHCMeCell()

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *image;

@end

@implementation QHCMeCell

+ (instancetype)cellWith:(UITableView *)tableView
{
    NSString *ID = @"meCell";
    QHCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.height = self.contentView.height - 10*QHCScreen_HRtio;
    self.imageView.width = self.imageView.height;
    self.imageView.centerY = self.contentView.centerY;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10*QHCScreen_WRtio;
    
    
    
}

@end
