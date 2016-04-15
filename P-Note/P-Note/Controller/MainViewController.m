//
// 主页面
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "MainViewController.h"
#import "FolderNoteCell.h"
#import "NoteFolderHelper.h"
#import "NoteFolder.h"
#import "FDAlertView.h"
#import "AddFolderView.h"
#import "NotesListViewController.h"
#import "SettingViewController.h"


@implementation MainViewController {

    // 私密开关
    BOOL pSwitch;
    // 保存的密码
    NSString *savePwd;

    NoteFolderHelper *_folderHelper;
    NSMutableArray *folderList;

    // 0 normal 1 edit 2 delete
    int mode;

    UIBarButtonItem *editBarItem;

    UIBarButtonItem *delBarItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"P Note"];


    editBarItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:nil target:self action:@selector(editMode)];
    delBarItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:nil target:self action:@selector(deleteMode)];

    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:editBarItem, delBarItem, nil];


    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn2 setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(navigationRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [super setNavigationRightBtn:[[UIBarButtonItem alloc] initWithCustomView:btn2]];

    [self initCollection];

    [self initData];

    [[NSNotificationCenter defaultCenter]
            addObserver:self selector:@selector(selectAllFolders)
                   name:@"UpdateFolderCollectionView" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 初始化collectionview
 */
- (void)initCollection {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    flowLayout.minimumInteritemSpacing = 1;//内部cell之间距离
    flowLayout.minimumLineSpacing = 5;//行间距

    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 3) / 4, 110);


    self.collectionView = [[UICollectionView alloc]                   initWithFrame:
            CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];

    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    UINib *nib = [UINib nibWithNibName:@"FolderNoteCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];

    [self.view addSubview:self.collectionView];
}

- (void)initData {
    pSwitch = [UserDefaultsUtils getAppInfoForKeyBool:@"p_switch"];
    savePwd = [UserDefaultsUtils getAppInfoForKey:@"pwd"];

    _folderHelper = [[NoteFolderHelper alloc] init];
    [self selectAllFolders];
}

- (void)selectAllFolders {

    [folderList removeAllObjects];

    folderList = [_folderHelper selectAllFolders];
    NoteFolder *defaultFolder = [[NoteFolder alloc] init];
    defaultFolder.id = 0;
    defaultFolder.name = @"添加";
    [folderList addObject:defaultFolder];

    [self.collectionView reloadData];
}

- (void)addOrUpdateFolder:(int)id name:(NSString *)name andPrivate:(BOOL)isPrivate {

    // 正常模式
    if (mode == 0) {
        if ([_folderHelper addFolder:name andPrivate:isPrivate]) {
            [Tools showTip:self andMsg:@"添加成功"];

            [self selectAllFolders];

            [self.collectionView reloadData];
        }
        else {
            [Tools showTip:self andMsg:@"添加失败"];
        }
    }
        // 编辑模式
    else if (mode == 1) {
        if ([_folderHelper updateFolder:id name:name andPrivate:isPrivate]) {
            [Tools showTip:self andMsg:@"修改成功"];

            [self selectAllFolders];

            [self.collectionView reloadData];
        }
        else {
            [Tools showTip:self andMsg:@"修改失败"];
        }
    }

}


- (void)navigationRightBtnClick {
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:true];
}

- (void)editMode {
    if (mode == 0) {
        mode = 1;
        editBarItem.title = @"完成";
        delBarItem.enabled = NO;
    }
    else {
        mode = 0;
        editBarItem.title = @"编辑";
        delBarItem.enabled = YES;
    }
    [self.collectionView reloadData];
}

- (void)deleteMode {
    if (mode == 0) {
        mode = 2;
        delBarItem.title = @"完成";
        editBarItem.enabled = NO;
    }
    else {
        mode = 0;
        delBarItem.title = @"删除";
        editBarItem.enabled = YES;
    }
    [self.collectionView reloadData];
}

/**
 * section
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 * 返回单元格数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return folderList.count;
}

/**
 * 返回一个 单元格布局
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FolderNoteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NoteFolder *folder = [folderList objectAtIndex:indexPath.row];
    if (folder.id != 0) {
        cell.imgFolder.image = [UIImage imageNamed:[NSString stringWithFormat:@"folder%d.png", (arc4random() % 11) + 1]];

        // 正常模式下
        if (mode == 0) {
            if (folder.isPrivate) {
                cell.ivPrivate.image = [UIImage imageNamed:@"private.png"];
                cell.ivPrivate.hidden = NO;
            }
            else {
                cell.ivPrivate.hidden = YES;
            }
        }
            // 编辑模式
        else if (mode == 1) {
            cell.ivPrivate.hidden = NO;
            cell.ivPrivate.image = [UIImage imageNamed:@"edit.png"];
        }
            // 删除模式
        else if (mode == 2) {
            cell.ivPrivate.hidden = NO;
            cell.ivPrivate.image = [UIImage imageNamed:@"delete.png"];
        }
    }
    else {
        cell.imgFolder.image = [UIImage imageNamed:@"add.png"];
        cell.ivPrivate.hidden = YES;
    }
    [cell setName:folder.name];
    return cell;
}

/**
 * 单击单元格
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NoteFolder *folder = [folderList objectAtIndex:indexPath.row];

    // 正常模式
    if (mode == 0) {
        // 添加
        if (folder.id == 0) {
            [self showAddOrUpdateDialog:nil];
        }
        else {
            // 私密开关开启 并且 设置过密码
            if (pSwitch && ![StringUtils isEmpty:savePwd] && folder.isPrivate) {
                [self openPwdInputDialog:nil andOnClicked:nil andCompletion:^(NSString *pwd) {
                    if ([pwd isEqualToString:savePwd]) {
                        [self jumpNoteList:folder];
                    }
                    else {
                        [Tools showTip:self andMsg:@"密码不正确"];
                    }
                }];
            }
            else {
                [self jumpNoteList:folder];
            }
        }
    }
        // 编辑模式
    else if (mode == 1) {
        // 私密开关开启 并且 设置过密码
        if (pSwitch && ![StringUtils isEmpty:savePwd]) {
            [self openPwdInputDialog:nil andOnClicked:nil andCompletion:^(NSString *pwd) {
                if ([pwd isEqualToString:savePwd]) {
                    [self showAddOrUpdateDialog:folder];
                }
                else {
                    [Tools showTip:self andMsg:@"密码不正确"];
                }
            }];
        }
        else {
            [self showAddOrUpdateDialog:folder];
        }
    }
        // 删除模式
    else if (mode == 2) {
        [super openAlertDialog:@"删除分类也即将删除该分类所有记事,确定删除?" onClick:^(void) {
            // 私密开关开启 并且 设置过密码
            if (pSwitch && ![StringUtils isEmpty:savePwd]) {
                [self openPwdInputDialog:nil andOnClicked:nil andCompletion:^(NSString *pwd) {
                    if ([pwd isEqualToString:savePwd]) {
                        [self deleteFolder:folder];
                    }
                    else {
                        [Tools showTip:self andMsg:@"密码不正确"];
                    }
                }];
            }
            else {
                [self deleteFolder:folder];
            }
        }];
    }
}

/**
 * 跳转到note 列表
 */
- (void)jumpNoteList:(NoteFolder *)folder {
    NotesListViewController *notesListViewController = [[NotesListViewController alloc]
            init:folder.id andName:folder.name];
    [self.navigationController pushViewController:notesListViewController animated:true];
}

/**
 * 弹出添加目录对话框
 */
- (void)showAddOrUpdateDialog:(NoteFolder *)folder {
    FDAlertView *alert = [[FDAlertView alloc] init];
    AddFolderView *contentView = [[NSBundle mainBundle] loadNibNamed:@"AddFolderView" owner:nil options:nil].lastObject;
    [contentView init:self andFrame:CGRectMake(0, 0, 270, 215) folder:folder];
    alert.contentView = contentView;
    [alert show];
}

/**
 * 删除目录
 */
- (void)deleteFolder:(NoteFolder *)folder {
    @try {
        [_folderHelper deleteFolder:folder.id];
        [Tools showTip:self andMsg:@"删除成功"];
        [folderList removeObject:folder];
        [self.collectionView reloadData];
    }
    @catch (NSException *exception) {
        [Tools showTip:self andMsg:@"删除失败"];
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}

@end

