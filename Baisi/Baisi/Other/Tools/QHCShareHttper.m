//
//  QHCShareHttper.m
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCShareHttper.h"
@implementation QHCShareHttper

static QHCShareHttper * shareHttper;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHttper = [super allocWithZone:zone];
        
        shareHttper = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        NSOperationQueue *operaQueue = shareHttper.operationQueue;
        [shareHttper.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [operaQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [operaQueue setSuspended:YES];
                    break;
                default:
                    [operaQueue setSuspended:YES];
                    break;
            }
        }];
        
    });
    return shareHttper;
}

+(instancetype)shareHttper
{
    return [[self alloc] init];
}

/**
 *  重写原方法, 加入请求头信息(加密签名)
 */
-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSDictionary *dict = [self baseHeaderWithParameters:parameters URLString:URLString type:@"POST"];
    return [self POST:URLString parameters:dict progress:uploadProgress success:success failure:failure];
}

/**
 *  修改请求头: 在此方法里面进行加密
 */
-(NSDictionary *)baseHeaderWithParameters:(NSDictionary *)parameters URLString:(NSString *)URLString type:(NSString *)typer
{
    
    return parameters;
    
}

/**
 *  字典转json
 */
-(NSString *)dictToJsonWithDict:(NSDictionary *)dict
{
    NSError *error;
    NSString *jsonStr;
    if (QHCDict(dict)) {
        
        NSData *dat = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        
        if (error) {
            return nil;
        }
        jsonStr = [[NSString alloc] initWithData:dat encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}


@end
