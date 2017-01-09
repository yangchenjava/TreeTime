//
//  YCBaseTableViewController.m
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <objc/message.h>

#import "YCBaseTableViewController.h"
#import "YCBaseTableViewCell.h"
#import "YCBaseTableViewCellGroup.h"
#import "YCBaseTableViewCellItem.h"

@interface YCBaseTableViewController ()

@end

@implementation YCBaseTableViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = YC_Color_RGB(75, 164, 135);
    self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    self.tableView.estimatedRowHeight = YC_CellDefaultHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 20;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YCBaseTableViewCellGroup *group = self.groupArray[indexPath.section];
    YCBaseTableViewCellItem *item = group.itemArray[indexPath.row];
    
    if (item.operation != nil) {
        item.operation(item);
    } else if (item.destClass != nil) {
        UIViewController *destViewController = [[item.destClass alloc] init];
        
        unsigned int count;
        Ivar *ivars = class_copyIvarList(item.destClass, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [[NSString stringWithUTF8String:ivar_getName(ivar)] substringFromIndex:1];
            id value = [item.instanceVariables valueForKey:key];
            if (value && ![value isEqual:[NSNull null]]) {
                [destViewController setValue:value forKey:key];
            }
        }
        
        destViewController.navigationItem.title = item.title;
        [self.navigationController pushViewController:destViewController animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YCBaseTableViewCellGroup *group = self.groupArray[section];
    return group.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCBaseTableViewCellGroup *group = self.groupArray[indexPath.section];
    YCBaseTableViewCellItem *item = group.itemArray[indexPath.row];
    
    YCBaseTableViewCell *cell = [YCBaseTableViewCell cellWithTableView:tableView];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
    header.textLabel.font = [UIFont systemFontOfSize:15];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *) view;
    footer.textLabel.font = [UIFont systemFontOfSize:15];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YCBaseTableViewCellGroup *group = self.groupArray[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    YCBaseTableViewCellGroup *group = self.groupArray[section];
    return group.footer;
}

@end
