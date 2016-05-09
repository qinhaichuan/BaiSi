//
//  QHCLeftCell.h
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHCRecommendModel;
@interface QHCLeftCell : UITableViewCell
@property(nonatomic, strong) QHCRecommendModel *recommendModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
