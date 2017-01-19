//
//  YCBaseTableViewCellItem.h
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCBaseTableViewCellItem;

typedef void (^Operation)(YCBaseTableViewCellItem *);

@interface YCBaseTableViewCellItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) Operation operation;
@property (nonatomic, assign) Class destClass;
@property (nonatomic, strong) NSDictionary *instanceVariables;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subtitle:(NSString *)subtitle;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subtitle:(NSString *)subtitle destClass:(Class)destClass instanceVariables:(NSDictionary *)instanceVariables;

@end
