//
//  NewsViewModel.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "NewsViewModel.h"

#import "NewsModel.h"
#import "BaseRequest.h"
#import "MJExtension.h"


#define RequestURL @"http://113.108.222.107:80/TexmanAppServer/ifm/newsList.spr"

#define APICURREVENTS @"http://113.108.222.107:80/TexmanAppServer/ad/currevents.spr"

@interface NewsViewModel ()

@property (nonatomic, assign) NSInteger newsPageNum;

@end

@implementation NewsViewModel

- (instancetype)init {
    if (self = [super init]) {
        _newsPageNum = 0;
    }
    return self;
}




- (NSMutableArray *)newsListArray {
    
    if (!_newsListArray) {
        //
        _newsListArray = [[NSMutableArray alloc] init];
    }
    return _newsListArray;
}

- (NSMutableArray *)advertisArray {
    
    if (!_advertisArray) {
        //
        _advertisArray = [[NSMutableArray alloc] init];
    }
    return _advertisArray;
}





- (void)requestNewsSubscribeWithPage:(NSInteger)page completion:(void(^)())completion
{
    //请求参数
    NSMutableDictionary * parames = [NSMutableDictionary dictionary];
    parames[@"start"] = @(_newsPageNum);
    parames[@"size"]  = @(10);
    
    
    [BaseRequest post:RequestURL parameter:parames httpProgress:^(NSProgress *progress) {
        //
    } success:^(id responseObject, BOOL error) {
        //
        if (error) {
            if (self.newsPageNum == 0) {
                
                self.newsListArray = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            } else {
                
                [self.newsListArray addObjectsFromArray:[NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
            completion();
        }
        
    } failure:^(NSError *error) {
        //
        NSLog(@"error :%@",error.localizedDescription);

    }];
    
}



- (void)requestAdvertisingSubscribeCompletion:(void(^)(id responseObject))completion
{
    [BaseRequest post:APICURREVENTS parameter:nil httpProgress:^(NSProgress *progress) {
        //
    } success:^(id responseObject, BOOL error) {
        //
        if (error) {
            
            NSArray * adverArray = responseObject[@"data"];
            RACSequence *sequence = [[adverArray valueForKey:@"url"] rac_sequence];
            
            RACSignal *signal =  sequence.signal;
            
            [signal subscribeNext:^(NSString * x) {
                [self.advertisArray addObject:x];
                
                if (adverArray.count == self.advertisArray.count) completion(self.advertisArray);
            }];
            
        }
        
    } failure:^(NSError *error) {
        //
    }];
}



- (RACSignal *)updateNewsSignal {
    
    @weakify(self)
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //
        @strongify(self);
        
        [self requestNewsSubscribeWithPage:self.newsPageNum completion:^{
            //
            [subscriber sendNext:nil];
        }];
        return nil;
        
    }];
    
    self.newsPageNum = 0;
    
    return signal;

}


- (RACSignal *)updateMoreSignal {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //
        @strongify(self);
        [self requestNewsSubscribeWithPage:self.newsPageNum completion:^{
            //
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    self.newsPageNum += 10;
    return signal;
}


- (RACSignal *)updateAdvertisingSignal {
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //
        @strongify(self);
        [self requestAdvertisingSubscribeCompletion:^(id responseObject) {
            //
            [subscriber sendNext:responseObject];
        }];
        return nil;
    }];
    return signal;

}


@synthesize cellClickSubject = _cellClickSubject;
- (RACSubject *)cellClickSubject {

    if (!_cellClickSubject) {
        @synchronized (self) {
            if (!_cellClickSubject) {
                _cellClickSubject = [RACSubject subject];
            }
        }
    }
    return _cellClickSubject;
}












@end
