//
//  QHCHttpManger.m
//  Baisi
//
//  Created by QHC on 4/29/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCHttpManger.h"
#import <AFNetworking/AFNetworking.h>
#import "QHCShareHttper.h"
@implementation QHCHttpManger

+(void)getDataWithDict:(NSDictionary *)parameter success:(void (^)(NSDictionary *responseDict))success failure:(void (^)(NSError *errorMess))failure
{
    [self getData:parameter success:^(id data) {
        
        success(data);
    } failure:^(NSError *errorMessage) {
        
        failure(errorMessage);
    }];
    
}

+(void)getData:(NSDictionary *)parameter success:(void (^)(id data))success failure:(void (^)(NSError *errorMessage))failure
{
    QHCShareHttper *manager = [QHCShareHttper manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html", nil]];
    [manager POST:BASE_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];

}

@end
