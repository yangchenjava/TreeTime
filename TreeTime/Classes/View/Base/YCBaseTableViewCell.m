//
//  YCBaseTableViewCell.m
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <YCHelpKit/UIImage+Category.h>

#import "YCBaseTableViewCell.h"
#import "YCBaseTableViewCellItem.h"

@implementation YCBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"YCBaseTableViewCell";
    YCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YCBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:YC_Color_RGB(99, 104, 102)]];
        self.textLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setItem:(YCBaseTableViewCellItem *)item {
    _item = item;
    
    if (_item.icon.length) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    } else {
        self.imageView.image = nil;
    }
    if (_item.title.length) {
        self.textLabel.text = _item.title;
    } else {
        self.textLabel.text = nil;
    }
    if (_item.subtitle.length) {
        self.detailTextLabel.text = _item.subtitle;
    } else {
        self.detailTextLabel.text = nil;
    }
    
    if (_item.operation || _item.destClass) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

@end
