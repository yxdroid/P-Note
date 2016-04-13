//
// Created by yaxiongfang on 4/9/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "StringUtils.h"


@implementation StringUtils {

}
+ (BOOL)isEmpty:(NSString *)string {

    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end