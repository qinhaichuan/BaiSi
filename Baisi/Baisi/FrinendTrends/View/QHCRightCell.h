//
//  QHCRightCell.h
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHCRecommendUserModel;
@interface QHCRightCell : UITableViewCell
@property(nonatomic, strong) QHCRecommendUserModel *recommendUserModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
