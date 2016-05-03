
//
//  QHCOtherCell.m
//  Baisi
//
//  Created by QHC on 5/3/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCOtherCell.h"

@implementation QHCOtherCell

+(instancetype)cellWith:(UITableView *)tableView
{
    NSString *ID = @"otherCell";
    QHCOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[QHCOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}


@end
