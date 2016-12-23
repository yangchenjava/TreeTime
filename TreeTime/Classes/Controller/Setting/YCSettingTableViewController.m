//
//  YCSettingTableViewController.m
//  TreeTime
//
//  Created by yangc on 16/12/11.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import "YCSettingTableViewController.h"
#import "YCBaseTableViewCellGroup.h"
#import "YCBaseTableViewCellItem.h"
#import "YCTreeTimeUtils.h"
#import "YCSetting.h"

@interface YCSettingTableViewController ()

@end

@implementation YCSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blur_background"]];
    self.tableView.separatorColor = YC_Color_RGB(99, 104, 102);
    self.groupArray = @[[self group_0], [self group_1]];
}

- (YCBaseTableViewCellGroup *)group_0 {
    YCBaseTableViewCellItem *item_0 = [YCBaseTableViewCellItem itemWithTitle:@"静音模式"];
    item_0.operation = ^(YCBaseTableViewCellItem *item){};
    
    YCBaseTableViewCellItem *item_1 = [YCBaseTableViewCellItem itemWithTitle:@"震动"];
    item_1.operation = ^(YCBaseTableViewCellItem *item){};
    
    YCBaseTableViewCellItem *item_2 = [YCBaseTableViewCellItem itemWithTitle:@"树大时提醒我"];
    item_2.operation = ^(YCBaseTableViewCellItem *item){};
    
    YCBaseTableViewCellItem *item_3 = [YCBaseTableViewCellItem itemWithTitle:@"清除历史记录"];
    item_3.operation = ^(YCBaseTableViewCellItem *item){};
    
    YCBaseTableViewCellGroup *group = [[YCBaseTableViewCellGroup alloc] init];
    group.itemArray = @[item_0, item_1, item_2, item_3];
    return group;
}

- (YCBaseTableViewCellGroup *)group_1 {
    NSMutableArray *itemArray = [NSMutableArray array];
    
    YCBaseTableViewCellItem *item_0 = [YCBaseTableViewCellItem itemWithTitle:@"再看一次教学"];
    item_0.operation = ^(YCBaseTableViewCellItem *item){};
    [itemArray addObject:item_0];
    
    YCSetting *setting = [YCTreeTimeUtils setting];
    if (setting.loginName.length && setting.loginPassword.length) {
        YCBaseTableViewCellItem *item_1 = [YCBaseTableViewCellItem itemWithTitle:@"注销"];
        item_1.operation = ^(YCBaseTableViewCellItem *item){
            [YCTreeTimeUtils setSetting:nil];
            [YCTreeTimeUtils setupRootViewController];
        };
        [itemArray addObject:item_1];
    }
    
    
    YCBaseTableViewCellGroup *group = [[YCBaseTableViewCellGroup alloc] init];
    group.itemArray = itemArray;
    return group;
}

@end
