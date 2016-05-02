//
//  QHCSubTagCell.h
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHCSubTagModel;
@interface QHCSubTagCell : UITableViewCell

@property(nonatomic, strong) QHCSubTagModel *subTagModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
