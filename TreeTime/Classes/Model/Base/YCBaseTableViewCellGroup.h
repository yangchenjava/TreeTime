//
//  YCBaseTableViewCellGroup.h
//  TreeTime
//
//  Created by yangc on 16/11/22.
//  Copyright © 2016年 rgsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCBaseTableViewCellGroup : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray *itemArray;

@end
