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
-(BOOL) addFolder:(NSString *)name;

@end