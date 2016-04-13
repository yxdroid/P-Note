//
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "AddFolderView.h"
#import "FDAlertView.h"
#import "MainViewController.h"

@implementation AddFolderView


- (void)init:(MainViewController *)controller andFrame:(CGRect)frame {
    self.controller = controller;
    self.frame = frame;
    self.edtName.delegate = self;
}

- (IBAction)cancel:(id)sender {
    FDAlertView *alert = (FDAlertView *) self.superview;
    [alert hide];
}

- (IBAction)add:(id)sender {

    NSString *name = self.edtName.text;
    if ([StringUtils isEmpty:name]) {
        [Tools showTip:_controller andMsg:@"请输入分类名称"];
        return;
    }
    else {
        FDAlertView *alert = (FDAlertView *) self.superview;
        [alert hide];

        [[self controller] addFlolder:name];
    }
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
}

@end