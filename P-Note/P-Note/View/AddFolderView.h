//
// Created by yaxiongfang on 4/8/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;


@interface AddFolderView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *edtName;

@property(nonatomic, strong) MainViewController *controller;

-(void)init:(UIViewController *)controller andFrame:(CGRect)frame;

@end