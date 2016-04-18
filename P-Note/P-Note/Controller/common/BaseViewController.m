//
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "BaseViewController.h"
#import "FDAlertView.h"


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.translucent = NO;
}

- (void)navigationRightBtnClick {
    DebugLog(@"navigationRightBtnClick");
}

- (void)setNavigationRightBtn:(UIBarButtonItem *)btn {
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)setTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void)setTitleRightBtn:(NSString *)btn {

}

- (void)openPwdInputDialog:(NSString *)title andOnClicked:(RightTopBtnOnClicked)onClicked andCompletion:(InputCompletion)onInputComletion {
    FDAlertView *alert = [[FDAlertView alloc] init];
    PwdDialogView *contentView = [[NSBundle mainBundle] loadNibNamed:@"PwdDialogView" owner:nil options:nil].lastObject;
    [contentView init:self andFrame:CGRectMake(0, 0, 270, 184) andClicked:onClicked andCompletion:onInputComletion];
    if (title != nil) {
        contentView.titleLabel.text = title;
    }
    alert.contentView = contentView;
    [contentView showKeyBoard];
    [alert show];
}

- (void)openAlertDialog:(NSString *)msg onClick:(AlertDialogOnOk)onOk {
    FDAlertView *alert = [[FDAlertView alloc] init];
    AlertDialogView *contentView = [[NSBundle mainBundle] loadNibNamed:@"AlertDialogView" owner:nil options:nil].lastObject;
    [contentView initWitchMsg:CGRectMake(0, 0, 270, 169) msg:msg onClick:onOk];
    alert.contentView = contentView;
    [alert show];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addObserver:(NSString *)name selector:(SEL)aselector {
    [[NSNotificationCenter defaultCenter]
            addObserver:self selector:aselector
                   name:name object:nil];
}

- (void)postNotification:(NSString *)name obj:(id)obj {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}


@end