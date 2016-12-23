//
//  YCBaseTableViewCellItem.m
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import "YCBaseTableViewCellItem.h"

@implementation YCBaseTableViewCellItem

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title icon:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon {
    return [self itemWithTitle:title icon:icon subtitle:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subtitle:(NSString *)subtitle {
    return [self itemWithTitle:title icon:icon subtitle:subtitle destClass:Nil instanceVariables:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subtitle:(NSString *)subtitle destClass:(Class)destClass instanceVariables:(NSDictionary *)instanceVariables {
    YCBaseTableViewCellItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    item.subtitle = subtitle;
    item.destClass = destClass;
    item.instanceVariables = instanceVariables;
    return item;
}

@end
