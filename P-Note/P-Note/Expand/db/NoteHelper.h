// 笔记操作助手
// Created by yaxiongfang on 4/9/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NoteHelper : NSObject

/**
 * 添加笔记
 */
- (BOOL)addNote:(NSString *)title andContent:(NSString *)content andFolderId:(int)folderId;

/**
 * 更新笔记
 */
- (BOOL)updateNote:(NSString *)title andContent:(NSString *)content andFolderId:(int)folderId;

/**
 * 根据分类目录查询笔记
 */
- (NSMutableArray *)selectAllNotes:(int)folderId;

/**
 * 根据 id 删除笔记
 */
- (BOOL)delNoteById:(int)noteId;

@end