// 笔记数据模型
// Created by yaxiongfang on 4/9/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Note : NSObject

@property int id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *content;
@property int folderId;

@end