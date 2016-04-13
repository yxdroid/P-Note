//
// Created by yaxiongfang on 4/11/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//


@implementation Tools {

}

+ (void)showTip:(UIViewController *)controller andMsg:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    hud.color = TIP_BG_COLOR;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(msg, nil);
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppBuild {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}
@end