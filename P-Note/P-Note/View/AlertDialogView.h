//
//  AlertDialogView.h
//  P-Note
//
//  Created by yaxiongfang on 4/15/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个 右上角按钮点击回调
typedef void (^AlertDialogOnOk)(void);

@interface AlertDialogView : UIView

@property(weak, nonatomic) IBOutlet UILabel *labelMsg;

- (void)initWitchMsg:(CGRect)frame msg:(NSString *)msg onClick:(AlertDialogOnOk) onOkFs;

@end
