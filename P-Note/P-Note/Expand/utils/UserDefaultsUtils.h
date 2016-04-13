//
// Created by yaxiongfang on 4/13/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDefaultsUtils : NSObject

+ (void)saveAppInfoForObject:(NSString *)key andValue:(id)value;

+ (id)getAppInfoForKey:(NSString *)key;

+ (void)saveAppInfoForBool:(NSString *)key andValue:(BOOL)value;

+ (BOOL)getAppInfoForKeyBool:(NSString *)key;

+ (void)saveAppInfoForDouble:(NSString *)key andValue:(double)value;

+ (double)getAppInfoForKeyDouble:(NSString *)key;

+ (void)saveAppInfoForFloat:(NSString *)key andValue:(float)value;

+ (float)getAppInfoForKeyFloat:(NSString *)key;

+ (void)saveAppInfoForInteger:(NSString *)key andValue:(int)value;

+ (int)getAppInfoForKeyInteger:(NSString *)key;

@end