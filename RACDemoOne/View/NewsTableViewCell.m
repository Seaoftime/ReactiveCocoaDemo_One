//
//  NewsTableViewCell.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/13.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "NewsTableViewCell.h"

#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "ReactiveCocoa.h"

@implementation NewsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.smallImg.sd_layout.leftSpaceToView(self.contentView,12).topSpaceToView(self.contentView,10).widthIs(100).heightIs(100);
        
        [RACObserve(self, newsModel) subscribeNext:^(NewsModel *model) {
            //
            [self.smallImg sd_setImageWithURL:[NSURL URLWithString:model.sallimg]];
            [self.smallImg setHidden:[model.sallimg isEqualToString:@""]];
            [self.content setText:model.content];
            
            [self.title setText:model.title];
            
        }];
    }
    return self;
}


- (UIImageView *)smallImg {

    if (!_smallImg) {
        _smallImg = [[UIImageView alloc] init];
        _smallImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_smallImg];
    }
    return _smallImg;
}



- (UILabel *)title {

    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_title];
    }
    return _title;
}


- (UILabel *)content {

    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:16];
        _content.textColor = [UIColor grayColor];
        [self.contentView addSubview:_content];
    }
    return _content;
}




- (void)layoutSubviews {

    [self.title sd_resetLayout];
    [self.content sd_resetLayout];
    
    id x = _smallImg.hidden ? self.contentView :_smallImg;
    
    self.title.sd_layout.leftSpaceToView(x, 10).rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).heightIs(30);
    
    self.content.sd_layout.leftSpaceToView(x, 10).rightSpaceToView(self.contentView, 10).topSpaceToView(self.title, 10).bottomSpaceToView(self.contentView, 10);
    
    [super layoutSubviews];

}






















- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
