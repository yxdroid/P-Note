//
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "NoteFolderHelper.h"
#import "DBHelper.h"
#import "NoteFolder.h"


@implementation NoteFolderHelper {

}
- (NSMutableArray *)selectAllFolders {

    FMResultSet *rs = [[DBHelper shareInstance] doQuery:
            [NSString stringWithFormat:@"select * from %@ order by updateTime desc", FOLDERS_TABLE]];

    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([rs next]) {
        NoteFolder *folder = [[NoteFolder alloc] init];
        folder.id = [rs intForColumn:@"id"];
        folder.name = [rs stringForColumn:@"name"];
        [list addObject:folder];
    }
    return list;
}

- (BOOL)addFolder:(NSString *)name {
    NSString *sql = [NSString stringWithFormat:
            @"insert into %@ ('name', 'updateTime') values('%@', '%@')",
                    FOLDERS_TABLE, name, [NSDate date]];
    return [[DBHelper shareInstance] update:sql];
}

@end