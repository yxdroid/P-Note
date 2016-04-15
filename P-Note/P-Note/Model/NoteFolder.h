//
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NoteFolder : NSObject

@property int id;
@property BOOL isPrivate;
@property(nonatomic, strong) NSString *name;

@end