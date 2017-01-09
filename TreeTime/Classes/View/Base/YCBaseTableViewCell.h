//
//  YCBaseTableViewCell.h
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCBaseTableViewCellItem;

@interface YCBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) YCBaseTableViewCellItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
