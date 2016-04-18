//
// 所有viewcontroller 父类
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PwdDialogView.h"
#import "AlertDialogView.h"

// 通知观察者 更新folder 列表
#define NOTIFICATION_UPDATE_FOLDER @"UpdateFolderCollectionView"

// 通知观察者 更新 设置配置信息
#define NOTIFICATION_UPDATE_SETTING @"UpdateSetting"

// 通知观察者 更新folder 列表
#define NOTIFICATION_UPDATE_NOTE @"UpdateNoteList"


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

/**
 * 弹出询问对话框
 */
- (void)openAlertDialog:(NSString *)msg onClick:(AlertDialogOnOk)onOk;

/**
 * 移除观察者
 */
- (void)removeObserver;

/**
 * 添加一个观察者
 */
- (void)addObserver:(NSString *)name selector:(SEL)aselector;

/**
 * 给观察者发送更新通知
 */
- (void)postNotification:(NSString *)name obj:(id)obj;

@end