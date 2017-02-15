//
//  NewsViewModel.h
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NewsViewModel : NSObject

@property (nonatomic, strong)   NSMutableArray * newsListArray;
@property (nonatomic, strong)   NSMutableArray * advertisArray;
@property (nonatomic, strong)   RACSubject     * cellClickSubject;
@property (nonatomic, readonly) RACSignal      * updateNewsSignal;
@property (nonatomic, readonly) RACSignal      * updateMoreSignal;
@property (nonatomic, readonly) RACSignal      * updateAdvertisingSignal;


@end
