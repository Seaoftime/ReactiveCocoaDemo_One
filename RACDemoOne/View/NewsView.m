//
//  NewsView.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "NewsView.h"

@implementation NewsView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _sdCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        _sdCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _sdCycleScrollView.currentPageDotColor = [UIColor orangeColor];
        _sdCycleScrollView.autoScrollTimeInterval = 2.0;
        _sdCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _sdCycleScrollView.placeholderImage = [UIImage imageNamed:@"cyclePlaceholderImage"];
        [self addSubview:_sdCycleScrollView];
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
