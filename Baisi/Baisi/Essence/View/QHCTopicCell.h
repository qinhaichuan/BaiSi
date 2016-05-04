//
//  QHCTopicCell.h
//  Baisi
//
//  Created by QHC on 5/4/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHCTopicModel;
@interface QHCTopicCell : UITableViewCell

@property(nonatomic, strong) QHCTopicModel *topicModel;

+(instancetype)cellWith:(UITableView *)tableView;

@end
