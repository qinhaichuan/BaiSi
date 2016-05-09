//
//  QHCRightCell.m
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCRightCell.h"

@implementation QHCRightCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"rightCell";
    QHCRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCRightCell alloc] init];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = QHCRandom_Color
    }
    
    return self;
}

@end
