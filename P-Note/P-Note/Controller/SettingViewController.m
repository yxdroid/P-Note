//
//  SettingViewController.m
//  P-Note
//  设置页面
//  Created by yaxiongfang on 4/9/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"

@implementation SettingViewController {
    UITableView *_tableView;

    // 开关按钮
    UISwitch *switchBtn;
    // 是否开启私密保护
    BOOL switchValue;
    // 是否设置密码
    BOOL hasPwd;

    // 已经保存过的密码
    NSString *savedPwd;

    // 保存第一次输入的密码
    NSString *_tempPwd;
    // 统计输入次数
    int inputCount;

    // 标识是否验证通过
    BOOL checkPass;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";

    [self initTableView];

    switchValue = [UserDefaultsUtils getAppInfoForKeyBool:@"p_switch"];
    savedPwd = [UserDefaultsUtils getAppInfoForKey:@"pwd"];
    if (![StringUtils isEmpty:savedPwd]) {
        hasPwd = YES;
    }
}

/**
 * 初始化tableview
 */
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return switchValue ? 2 : 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = @"开启私密保护";
            switchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];

            [switchBtn setOn:switchValue];

            cell.accessoryView = switchBtn;
            [switchBtn addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"设置密码";
            if (hasPwd) {
                cell.detailTextLabel.text = @"已设置";
            }
            else {
                cell.detailTextLabel.text = @"未设置";
            }
        }
    }
    else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"当前版本";
            cell.detailTextLabel.text = [Tools getAppVersion];
        }
        else if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"关于";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (hasPwd && !checkPass) {
            [self checkOldPwd];
        }
        else {
            [self showSetPwdDialog];
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AboutViewController *aboutViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController pushViewController:aboutViewController animated:true];
    }
}

- (void)checkOldPwd {
    [self openPwdInputDialog:@"请输入旧密码" andOnClicked:nil andCompletion:^(NSString *pwd) {
        if (![pwd isEqualToString:savedPwd]) {
            [Tools showTip:self andMsg:@"旧密码输入不正确,无法修改"];
        }
        else {
            [self showSetPwdDialog];
        }
    }];
}

/**
 * 弹出添加目录对话框
 */
- (void)showSetPwdDialog {

    [self openPwdInputDialog:nil andOnClicked:^(void) {
        inputCount = 0;
        _tempPwd = @"";
    }          andCompletion:^(NSString *pwd) {
        inputCount++;
        if (inputCount == 1) {
            _tempPwd = pwd;
            [Tools showTip:self andMsg:@"请再次输入密码"];
        }
        else {
            DebugLog(@"%@ %@", _tempPwd, pwd);

            if (![pwd isEqualToString:_tempPwd]) {
                inputCount = 0;
                _tempPwd = @"";
                [Tools showTip:self andMsg:@"两次输入密码不一致"];
            }
            else {
                inputCount = 0;
                _tempPwd = @"";
                hasPwd = YES;
                [_tableView reloadData];
                [Tools showTip:self andMsg:@"密码设置成功"];
                [UserDefaultsUtils saveAppInfoForObject:@"pwd" andValue:pwd];
            }
        }
        DebugLog(@"andCompletion");
    }];
}

- (IBAction)onSwitchValueChanged:(id)sender {
    UISwitch *switchBtn = (UISwitch *) sender;

    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (int i = 1; i < 2; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }

    [_tableView beginUpdates];
    if (switchBtn.isOn) {
        [UserDefaultsUtils saveAppInfoForBool:@"p_switch" andValue:YES];
        switchValue = YES;
        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        [UserDefaultsUtils saveAppInfoForBool:@"p_switch" andValue:NO];
        switchValue = NO;
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    [_tableView endUpdates];
}

@end
