//
//  FirstPageController.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/9.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "FirstPageController.h"

#import "NewsView.h"
#import "NewsTableViewCell.h"
#import "NewsViewModel.h"
#import "MJRefresh.h"


@interface FirstPageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NewsViewModel *newsViewModel;
@property (nonatomic, strong) NewsView      *newsView;
@property (nonatomic, strong) UITableView   *newsTableV;

@end

@implementation FirstPageController


#pragma mark ----------------------------- UI


- (UITableView *)newsTableV {
    if (!_newsTableV) {
        _newsTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _newsTableV.backgroundColor = [UIColor whiteColor];
        _newsTableV.delegate = self;
        _newsTableV.dataSource = self;
        _newsTableV.rowHeight = 120;
        _newsTableV.tableHeaderView = self.newsView;
        
    }
    return _newsTableV;
}

- (NewsView *)newsView {

    if (!_newsView) {
        _newsView = [[NewsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
        _newsView.backgroundColor = [UIColor orangeColor];
    }
    return _newsView;
}


- (NewsViewModel *)newsViewModel {
    if (!_newsViewModel) {
        _newsViewModel = [[NewsViewModel alloc] init];
    }
    return _newsViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self.view addSubview:self.newsTableV];
    
    [self setupUI];

    
    [self clickedNewsViewModel];
    
    
}


- (void)clickedNewsViewModel {

    @weakify(self);
    [[self.newsViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal ]subscribeNext:^(id x) {
        
        //@strongify(self);
        //
        
    }];
    
}



- (void)setupUI {
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)]subscribeNext:^(RACTuple * x) {
        NSIndexPath *index = x.second;
        NSLog(@"%s,cell被点击了 :%ld",__FUNCTION__,index.row);
        
        [self.newsViewModel.cellClickSubject sendNext:nil];
        
    }];
    
    [self.newsViewModel.updateAdvertisingSignal subscribeNext:^(NSArray * advers) {
        @strongify(self);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.newsView.sdCycleScrollView.imageURLStringsGroup = advers;
        });
    }];
    
    
    [self.newsTableV addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.newsTableV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(getHistoryData)];
    
    [self.newsTableV.header beginRefreshing];
}

#pragma mark ------------------------刷新 TableView
- (void)getNewData {
    
    @weakify(self);
    [self.newsViewModel.updateNewsSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.newsTableV.header endRefreshing];
        [self.newsTableV.footer endRefreshing];
        [self.newsTableV reloadData];
    }];
}

- (void)getHistoryData {
    
    @weakify(self);
    [self.newsViewModel.updateMoreSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.newsTableV.header endRefreshing];
        [self.newsTableV.footer endRefreshing];
        [self.newsTableV reloadData];
    }];
}




#pragma mark ------------------------TableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsViewModel.newsListArray.count;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"newsCell";
    
    NewsTableViewCell *cell= [self.newsTableV dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellid];
    }
    
    [cell setNewsModel:(NewsModel *)self.newsViewModel.newsListArray[indexPath.item]];
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
