//
// Created by yaxiongfang on 4/9/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "NoteHelper.h"
#import "DBHelper.h"
#import "Note.h"


@implementation NoteHelper {

}

- (BOOL)addNote:(NSString *)title andContent:(NSString *)content andFolderId:(int)folderId {
    NSString *sql = [NSString stringWithFormat:
            @"insert into %@ ('title', 'content','updateTime', 'folderId') "
                    "values('%@', '%@','%@', '%d')", NOTES_TABLE, title, content, [NSDate date], folderId];

    return [[DBHelper shareInstance] update:sql];
}

- (BOOL)updateNote:(NSString *)title andContent:(NSString *)content andFolderId:(int)folderId {
    NSString *sql = [NSString stringWithFormat:
            @"update %@ set 'title' = '%@', 'content' = '%@', 'updateTime' = '%@' where id = '%d'",
                    NOTES_TABLE, title, content, [NSDate date], folderId];

    return [[DBHelper shareInstance] update:sql];
}

- (NSMutableArray *)selectAllNotes:(int)folderId {

    NSString *sql = [NSString stringWithFormat:@"select * from %@ where folderId = '%d' order by updateTime desc", NOTES_TABLE, folderId];
    FMResultSet *rs = [[DBHelper shareInstance] doQuery:sql];

    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([rs next]) {
        Note *note = [[Note alloc] init];
        note.id = [rs intForColumn:@"id"];
        note.title = [rs stringForColumn:@"title"];
        note.content = [rs stringForColumn:@"content"];
        note.folderId = [rs intForColumn:@"folderId"];
        [list addObject:note];
    }
    [rs close];
    return list;
}

- (BOOL)delNoteById:(int)noteId {
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = '%d'", NOTES_TABLE, noteId];
    return [[DBHelper shareInstance] update:sql];
}

@end