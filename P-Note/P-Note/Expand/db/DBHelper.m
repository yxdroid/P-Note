// 数据库操作工具类
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <fmdb/FMDatabase.h>
#import "DBHelper.h"

@implementation DBHelper

// 单例对象
static DBHelper *_instance;

// 标识数据库是否被打开
BOOL dbIsOpen = true;

// 数据库操作对象
FMDatabase *db;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];

        db = [[FMDatabase alloc] initWithPath:[_instance getPath]];
        [db setUserVersion:DB_VERSION];
        
        if (![db open]) {
            dbIsOpen = false;
            DebugLog(@"数据库打开失败!");
        }

        // 初始化数据库表
        [_instance initTables];

    });

    return _instance;
}

/**
 * 初始化数据表
 */
- (void)initTables {
    for (id table in tableArray) {
        [self createTable:table];
    }
}

- (void)createTable:(NSString *)sql {
    BOOL res = [db executeUpdate:sql];
    if (res) {
        DebugLog(@"表创建成功");
    }
    else {
        DebugLog(@"表创建失败");
    }
}

/**
 * 判断表是否存在
 */
- (BOOL)isTableOK:(NSString *)tableName {
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        DebugLog(@"isTableOK %d", count);

        if (0 == count) {
            return NO;
        }
        else {
            return YES;
        }
    }

    return NO;
}

- (FMResultSet *)doQuery:(NSString *)sql {
    return [db executeQuery:sql];
}

- (BOOL)update:(NSString *)sql {
    return [db executeUpdate:sql];
}

- (BOOL)columnExists:(NSString *)column inTableWithName:(NSString *)tableName {
    return [db columnExists:column inTableWithName:tableName];
}


/**
 * 释放
 */
- (void)dbRelease {
    if (db != nil && dbIsOpen) {
        @try {
            [db close];
        }
        @catch (NSException *exception) {
            DebugLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
        }
    }
}


/**
 * 获取db 默认保存路径
 */
- (NSString *)getPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

    NSString *path = [NSString stringWithFormat:@"%@/%@", docDir, DB_NAME];

    DebugLog(@"db path = %@", path);

    return path;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [DBHelper shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [DBHelper shareInstance];
}

@end