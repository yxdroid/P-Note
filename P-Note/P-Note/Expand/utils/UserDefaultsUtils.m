//
// Created by yaxiongfang on 4/13/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "UserDefaultsUtils.h"


@implementation UserDefaultsUtils {

}
+ (void)saveAppInfoForObject:(NSString *)key andValue:(id)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+ (id)getAppInfoForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}


+ (void)saveAppInfoForBool:(NSString *)key andValue:(BOOL)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}


+ (BOOL)getAppInfoForKeyBool:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

+ (double)getAppInfoForKeyDouble:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults doubleForKey:key];
}

+ (float)getAppInfoForKeyFloat:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:key];
}

+ (int)getAppInfoForKeyInteger:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:key];
}

+ (void)saveAppInfoForDouble:(NSString *)key andValue:(double)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:value forKey:key];
    [defaults synchronize];
}

+ (void)saveAppInfoForFloat:(NSString *)key andValue:(float)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    [defaults synchronize];
}

+ (void)saveAppInfoForInteger:(NSString *)key andValue:(int)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

@end