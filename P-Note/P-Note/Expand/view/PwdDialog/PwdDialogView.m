//
//  PwdDialogView.m
//  P-Note
//
//  Created by yaxiongfang on 4/11/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import "PwdDialogView.h"
#import "SettingViewController.h"
#import "FDAlertView.h"

@implementation PwdDialogView {
    RightTopBtnOnClicked _onClicked;
}

- (void) init:(UIViewController *)controller andFrame:(CGRect)frame
   andClicked:(RightTopBtnOnClicked)onClicked
andCompletion:(InputCompletion)onInputComletion {

    self.controller = controller;
    self.frame = frame;

    _onClicked = onClicked;

    self.pwdInput.places = 6;
    self.pwdInput.textField.delegate = self;

    self.pwdInput.PWDInputViewDidCompletion = ^(NSString *text) {
        if (onInputComletion) {
            [self close];
            self.pwdInput.textField.text = @"";
            onInputComletion(text);
        }
    };
}

- (void)showKeyBoard {
    [self.pwdInput beginInput];
}

- (IBAction)cancelOrOk:(id)sender {
    if (_onClicked) {
        _onClicked();
    }
    [self close];
}

- (void)close {
    FDAlertView *alert = (FDAlertView *) self.superview;
    [alert hide];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置视图移动的位移
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 100,
            self.frame.size.width, self.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //设置动画的名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:0.20];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置视图移动的位移
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 100, self.frame.size.width, self.frame.size.height);
    //设置动画结束
    [UIView commitAnimations];

    [self close];
}

@end
