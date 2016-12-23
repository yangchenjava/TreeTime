//
//  YCRankTableViewController.m
//  TreeTime
//
//  Created by yangc on 16/12/11.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
#import <YCHelpKit/MBProgressHUD+Category.h>
#import <YCHelpKit/UIView+Category.h>

#import "YCRankTableViewController.h"
#import "YCRankTableHeaderView.h"
#import "YCRankTopTableViewCell.h"
#import "YCRankTableViewCell.h"
#import "YCMainBiz.h"
#import "YCRankBiz.h"
#import "YCRankParam.h"
#import "YCRankResult.h"
#import "YCTreeTimeUtils.h"
#import "YCSetting.h"

@interface YCRankTableViewController ()

@property (nonatomic, weak) YCRankTableHeaderView *tableHeaderView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation YCRankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专注排行榜";
    
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    YCRankTableHeaderView *tableHeaderView = [YCRankTableHeaderView tableHeaderView];
    self.tableView.tableHeaderView = tableHeaderView;
    _tableHeaderView = tableHeaderView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refresh {
    YCRankParam *param = [[YCRankParam alloc] init];
    param.userId = [YCTreeTimeUtils setting].userId;
    param.data = [YCMainBiz mainNotSyncWithUserId:param.userId];
    [YCRankBiz rankWithParam:param success:^(NSArray *array) {
        _array = array;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSString *errorMsg) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:errorMsg];
    }];
    /** 测试数据
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
         dispatch_async(dispatch_get_main_queue(), ^{
             NSMutableArray *aa = [NSMutableArray array];
             for (int i = 0; i < 10; i++) {
                 YCRankResult *rankResult = [[YCRankResult alloc] init];
                 rankResult.userName = [NSString stringWithFormat:@"小明%d", i];
                 rankResult.count = 15 - i;
                 rankResult.score = 180 - i;
                 [aa addObject:rankResult];
             }
             _array = aa;
             [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
         });
     }); */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCRankResult *rankResult = _array[indexPath.row];
    rankResult.number = (int) indexPath.row + 1;
    
    UITableViewCell *cell;
    if (indexPath.row < 3) {
        YCRankTopTableViewCell *rankTopCell = [YCRankTopTableViewCell cellWithTableView:tableView];
        rankTopCell.rankResult = rankResult;
        cell = rankTopCell;
    } else {
        YCRankTableViewCell *rankCell = [YCRankTableViewCell cellWithTableView:tableView];
        rankCell.rankResult = rankResult;
        cell = rankCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 85.0;
        case 1:
            return 80.0;
        case 2:
            return 75.0;
        default:
            return 70.0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -(YC_StatusBarHeight + YC_NavigationBarHeight)) {
        [_tableHeaderView startFlow];
    } else {
        [_tableHeaderView stopFlow];
    }
}

@end
