//
//  BaseRequest.h
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/9.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSURLSessionTask baseSessionTask;

@interface BaseRequest : NSObject


+ (instancetype)sharedRequest;

+ (baseSessionTask *)post:(NSString *)url parameter:(NSDictionary *)parameters httpProgress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject, BOOL error)) success failure:(void (^)(NSError * error)) failure;




@end
