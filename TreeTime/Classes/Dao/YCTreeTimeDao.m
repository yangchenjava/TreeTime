//
//  YCTreeTimeDao.m
//  TreeTime
//
//  Created by yangc on 16/12/9.
//  Copyright © 2016年 yangc. All rights reserved.
//

#import <FMDB/FMDB.h>

#import "YCTreeTimeDao.h"
#import "YCAnalysisResult.h"

@implementation YCTreeTimeDao

static FMDatabaseQueue *_queue;

+ (void)initialize {
    NSString *path = [YC_Dir_Document stringByAppendingPathComponent:@"TreeTime.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_tree_time (id integer not null primary key autoincrement, score integer, create_time text, status integer, user_id integer, sync integer);"];
    }];
}

+ (void)insertWithParam:(YCMainParam *)param {
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = [db executeUpdate:@"insert into t_tree_time (score, create_time, status, user_id, sync) values (?, ?, ?, ?, ?);", @(param.score), param.createTime, @(param.status), @(param.userId), @(param.sync)];
        if (!result) {
            *rollback = true;
        }
    }];
}

+ (void)updateWithID:(long)ID status:(YCMainStatus)status {
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = [db executeUpdate:@"update t_tree_time set status = ? where id = ?;", @(status), @(ID)];
        if (!result) {
            *rollback = true;
        }
    }];
}

+ (void)updateWithID:(long)ID sync:(BOOL)sync {
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = [db executeUpdate:@"update t_tree_time set sync = ? where id = ?;", @(sync), @(ID)];
        if (!result) {
            *rollback = true;
        }
    }];
}

+ (YCMainParam *)findLastWithUserId:(long)userId {
    YCMainParam *param = [[YCMainParam alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select id, score, create_time, status, user_id, sync from t_tree_time where user_id = ? order by id desc limit 1;", @(userId)];
        if (rs.next) {
            param.ID = [rs longForColumn:@"id"];
            param.score = [rs intForColumn:@"score"];
            param.createTime = [rs stringForColumn:@"create_time"];
            param.status = [rs intForColumn:@"status"];
            param.userId = [rs longForColumn:@"user_id"];
            param.sync = [rs intForColumn:@"sync"];
        }
        [rs close];
    }];
    return param;
}

+ (NSArray *)findNotSyncWithUserId:(long)userId {
    NSMutableArray *array = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select id, score, create_time, status, user_id, sync from t_tree_time where user_id = ? and sync = 0;", @(userId)];
        while (rs.next) {
            YCMainParam *param = [[YCMainParam alloc] init];
            param.ID = [rs longForColumn:@"id"];
            param.score = [rs intForColumn:@"score"];
            param.createTime = [rs stringForColumn:@"create_time"];
            param.status = [rs intForColumn:@"status"];
            param.userId = [rs longForColumn:@"user_id"];
            param.sync = [rs intForColumn:@"sync"];
            [array addObject:param];
        }
        [rs close];
    }];
    return array.copy;
}

+ (NSDictionary *)findWithUserId:(long)userId startTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select count(id) total, sum(score) score, create_time, status from t_tree_time where user_id = ? and create_time >= ? and create_time <= ? group by create_time, status;", @(userId), startTime, endTime];
        while (rs.next) {
            NSString *createTime = [rs stringForColumn:@"create_time"];
            YCAnalysisResult *result = [dict objectForKey:createTime];
            if (!result) {
                result = [[YCAnalysisResult alloc] init];
                [dict setObject:result forKey:createTime];
            }
            if ([rs intForColumn:@"status"] == YCMainStatusSuccess) {
                result.green = [rs intForColumn:@"total"];
                result.score = [rs intForColumn:@"score"];
            } else {
                result.yellow = [rs intForColumn:@"total"];
            }
        }
        [rs close];
    }];
    return dict;
}

@end
