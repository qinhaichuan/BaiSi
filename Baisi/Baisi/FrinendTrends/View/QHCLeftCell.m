//
//  QHCLeftCell.m
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCLeftCell.h"

@implementation QHCLeftCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"leftCell";
    QHCLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCLeftCell alloc] init];
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
