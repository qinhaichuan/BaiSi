//
//  QHCRecommendModel.h
//  Baisi
//
//  Created by QHC on 5/9/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCRecommendModel : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *id;

/** 用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
/** 总数 */
@property (nonatomic, assign) NSInteger total;

@end
