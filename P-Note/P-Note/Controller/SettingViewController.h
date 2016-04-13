//
//  SettingViewController.h
//  P-Note
//
//  Created by yaxiongfang on 4/9/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end
