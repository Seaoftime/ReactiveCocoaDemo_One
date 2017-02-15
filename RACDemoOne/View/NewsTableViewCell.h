//
//  NewsTableViewCell.h
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) NewsModel   *newsModel;

@property (nonatomic, strong) UILabel     *content;
@property (nonatomic, strong) UILabel     *title;
@property (nonatomic, strong) UIImageView *smallImg;



@end
