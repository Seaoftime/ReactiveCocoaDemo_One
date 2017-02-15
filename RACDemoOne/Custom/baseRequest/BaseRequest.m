//
//  BaseRequest.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/9.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "BaseRequest.h"

#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"

static BaseRequest *baseSessionRequest = nil;

@implementation BaseRequest

+ (instancetype)sharedRequest {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseSessionRequest = [[BaseRequest alloc] init];
        
    });
    
    return baseSessionRequest;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseSessionRequest = [super allocWithZone:zone];
    });
    return baseSessionRequest;
}


+ (AFHTTPSessionManager *)createAFHTTPSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30.f;
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        
        manager.responseSerializer = response;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
        
        
    });
    return manager;
    
}



+ (baseSessionTask *)post:(NSString *)url parameter:(NSDictionary *)parameters httpProgress:(void (^)(NSProgress *))progress success:(void (^)(id, BOOL))success failure:(void (^)(NSError *))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [self createAFHTTPSessionManager];
    return [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if ([responseObject[@"result"][@"code"] isEqualToString:@"200"]) {
            //
            success ? success(responseObject,YES) : nil;
            
        } else {
            success ? success(responseObject,NO) : nil;
            
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure ? failure(error) : nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
}



















@end
