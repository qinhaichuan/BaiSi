//
//  QHCShareHttper.h
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface QHCShareHttper : AFHTTPSessionManager

+ (instancetype)shareHttper;

@end
