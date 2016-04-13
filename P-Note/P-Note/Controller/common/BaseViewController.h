//
// 所有viewcontroller 父类
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PwdDialogView.h"


@interface BaseViewController : UIViewController

/**
 * 设置显示标题
 */
- (void)setTitle:(NSString *)title;

/**
 * 标题栏右边按钮单击
 */
- (void)navigationRightBtnClick;

/**
 * 设置标题栏右边按钮
 */
- (void)setNavigationRightBtn:(UIBarButtonItem *)btn;

/**
 * 打开密码输入对话框
 */
- (void)openPwdInputDialog:(NSString *)title andOnClicked:(RightTopBtnOnClicked)onClicked andCompletion:(InputCompletion)onInputComletion;

@end