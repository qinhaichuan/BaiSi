//
//  QHCCommentCell.h
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QHCCommentModel;
@interface QHCCommentCell : UITableViewCell

@property(nonatomic, strong) QHCCommentModel *commentModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
