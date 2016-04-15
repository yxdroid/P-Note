//
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConfig.h"
#import "FMDB.h"

@interface DBHelper : NSObject

/**
 * 单例创建对象
 */
+ (instancetype)shareInstance;

/**
 * 释放数据库
 */
- (void)dbRelease;

/**
 * 查询
 */
- (FMResultSet *)doQuery:(NSString *)sql;

/**
 * 插入,修改,删除
 */
- (BOOL)update:(NSString *)sql;

/**
 * 判断表里是否存在该字段
 */
- (BOOL)columnExists:(NSString *)column inTableWithName:(NSString *)tableName;

@end