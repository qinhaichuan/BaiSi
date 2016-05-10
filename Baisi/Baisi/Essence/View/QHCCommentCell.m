//
//  QHCCommentCell.m
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCCommentCell.h"

@implementation QHCCommentCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"commentCell";
    QHCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = QHCRandom_Color
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

}

- (void)setCommentModel:(QHCCommentModel *)commentModel
{
    _commentModel = commentModel;
    
    

}

@end
