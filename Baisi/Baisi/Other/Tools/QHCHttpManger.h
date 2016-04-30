//
//  QHCHttpManger.h
//  Baisi
//
//  Created by QHC on 4/29/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHCHttpManger : NSObject

+ (void)getDataWithDict:(NSDictionary *)parameter success:(void(^)(NSDictionary *responseDict))success failure:(void(^)(NSError *errorMess))failure;

@end
