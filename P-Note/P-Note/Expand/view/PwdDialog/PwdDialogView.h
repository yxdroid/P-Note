//
//  PwdDialogView.h
//  P-Note
//
//  Created by yaxiongfang on 4/11/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PwdInputView.h"

@class SettingViewController;

// 定义一个 右上角按钮点击回调
typedef void (^RightTopBtnOnClicked)(void);

// 定义密码输入完成自动执行回调
typedef void (^InputCompletion)(NSString *pwd);


@interface PwdDialogView : UIView <UITextFieldDelegate>

@property(nonatomic, strong) SettingViewController *controller;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


// 右上角按钮 isSetting 为true 时 显示确定  为false时 显示取消
@property(weak, nonatomic) IBOutlet UIButton *topRightBtn;

// 输入控件
@property(weak, nonatomic) IBOutlet PwdInputView *pwdInput;

- (void)init:(UIViewController *)controller andFrame:(CGRect)frame andClicked:(RightTopBtnOnClicked)onClicked andCompletion:(InputCompletion)onInputComletion;

- (void)showKeyBoard;

@end
