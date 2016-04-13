//
// Created by yaxiongfang on 4/11/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtils.h"
#import "UserDefaultsUtils.h"

//#define showTip(controller, msg) {MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES]; hud.color = APP_COLOR;hud.contentColor = [UIColor whiteColor];hud.mode = MBProgressHUDModeText;hud.label.text = NSLocalizedString(msg, nil);hud.offset = CGPointMake(0.f, MBProgressMaxOffset);[hud hideAnimated:YES afterDelay:3.f];}

@interface Tools : NSObject

/**
 * window 级别显示提示
 */
+ (void)showTip:(UIViewController *)controller andMsg:(NSString *)msg;

/**
 * 获取版本号
 */
+ (NSString *)getAppVersion;

/**
 * 获取build 号
 */
+ (NSString *)getAppBuild;

@end