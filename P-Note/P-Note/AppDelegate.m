//
//  AppDelegate.m
//  P-Note
//
//  Created by yaxiongfang on 4/7/16.
//  Copyright (c) 2016 yxfang. All rights reserved.
//


#import "AppDelegate.h"
#import "MainViewController.h"
#import "Colors.h"
#import "DBHelper.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UINavigationController *mainViewController = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:APP_COLOR];        //UIColorFromRGB(0x1f1f1f)
        NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
        [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];               //UIColorFromRGB(0xdadada)
    } else {
        [[UINavigationBar appearance] setBackgroundColor:[UIColor orangeColor]];
    }

    [NSThread sleepForTimeInterval:1.5];//设置启动页面时间

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 释放 数据库资源
    [[DBHelper shareInstance] dbRelease];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end