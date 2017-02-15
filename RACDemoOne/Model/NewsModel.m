//
//  NewsModel.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nid":@"id"};
}

@end
