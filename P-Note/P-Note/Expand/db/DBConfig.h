//
// Created by yaxiongfang on 4/12/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_VERSION 2

#define DB_NAME @"p-note.db"
#define FOLDERS_TABLE  @"folders_table"
#define NOTES_TABLE  @"notes_table"

#define tableArray @[@"create table if not exists folders_table(id integer primary key autoincrement, name text, updateTime datetime, isPrivate integer)",\
                     @"create table if not exists notes_table(id integer primary key autoincrement, title text, content text,updateTime datetime, folderId integer)"]

@interface DBConfig : NSObject

@end