//
//  YCRankTopTableViewCell.h
//  TreeTime
//
//  Created by yangc on 16/12/17.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCRankResult;

@interface YCRankTopTableViewCell : UITableViewCell

@property (nonatomic, strong) YCRankResult *rankResult;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
