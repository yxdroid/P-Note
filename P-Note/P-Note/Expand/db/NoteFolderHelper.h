// note 目录业务处理
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NoteFolderHelper : NSObject
/**
 * 查询所有的分类文件夹目录
 */
- (NSMutableArray *)selectAllFolders;

/**
 * 添加一个分类目录
 */
- (BOOL)addFolder:(NSString *)name andPrivate:(BOOL)isPrivate;

/**
 * 编辑修改分类目录
 */
-(BOOL) updateFolder:(int)id name:(NSString *)name andPrivate:(BOOL)isPrivate;

/**
 * 删除分类
 */
-(void) deleteFolder:(int)id;

/**
 * 清空所有
 */
-(void) deleteAll;

@end