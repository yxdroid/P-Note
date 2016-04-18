// 记事分类 数据库操作
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "NoteFolderHelper.h"
#import "DBHelper.h"
#import "NoteFolder.h"


@implementation NoteFolderHelper {

}

- (instancetype)init {
    if ([super init]) {

    }
    //[self updateTable];
    return self;
}

- (void)updateTable {
    // folder 表添加了 isPrivate字段
    if (![[DBHelper shareInstance] columnExists:@"isPrivate" inTableWithName:FOLDERS_TABLE]) {

        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ integer", FOLDERS_TABLE, @"isPrivate"];
        [[DBHelper shareInstance] update:sql];
    }
}

- (NSMutableArray *)selectAllFolders {

    FMResultSet *rs = [[DBHelper shareInstance] doQuery:
            [NSString stringWithFormat:@"select * from %@", FOLDERS_TABLE]];

    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([rs next]) {
        NoteFolder *folder = [[NoteFolder alloc] init];
        folder.id = [rs intForColumn:@"id"];
        folder.isPrivate = [rs intForColumn:@"isPrivate"];
        folder.name = [rs stringForColumn:@"name"];
        [list addObject:folder];
    }
    [rs close];
    return list;
}

- (BOOL)addFolder:(NSString *)name andPrivate:(BOOL)isPrivate {
    NSString *sql = [NSString stringWithFormat:
            @"insert into %@ ('name', 'updateTime', 'isPrivate') values('%@', '%@', '%d')",
                    FOLDERS_TABLE, name, [NSDate date], isPrivate ? 1 : 0];
    return [[DBHelper shareInstance] update:sql];
}

- (BOOL)updateFolder:(int)id name:(NSString *)name andPrivate:(BOOL)isPrivate {
    NSString *sql = [NSString stringWithFormat:
            @"update %@ set 'name' = '%@', 'updateTime' = '%@', 'isPrivate' = '%d' where id = '%d'",
                    FOLDERS_TABLE, name, [NSDate date], isPrivate ? 1 : 0, id];

    return [[DBHelper shareInstance] update:sql];
}

- (void)deleteFolder:(int)id {
    NSString *delFolderSql = [NSString stringWithFormat:@"delete from %@ where id = %d", FOLDERS_TABLE, id];
    NSString *delNoteSql = [NSString stringWithFormat:@"delete from %@ where folderId = %d", NOTES_TABLE, id];

    [[DBHelper shareInstance] update:delFolderSql];
    [[DBHelper shareInstance] update:delNoteSql];
}

- (void)deleteAll {
    NSString *delFolderSql = [NSString stringWithFormat:@"delete from %@", FOLDERS_TABLE];
    NSString *delNoteSql = [NSString stringWithFormat:@"delete from %@", NOTES_TABLE];

    [[DBHelper shareInstance] update:delFolderSql];
    [[DBHelper shareInstance] update:delNoteSql];
}


@end