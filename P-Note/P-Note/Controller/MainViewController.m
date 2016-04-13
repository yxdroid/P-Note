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
    NoteFolderHelper *_folderHelper;
    NSMutableArray *folderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"P Note"];


    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn2 setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(navigationRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [super setNavigationRightBtn:[[UIBarButtonItem alloc] initWithCustomView:btn2]];

    [self initData];

    [self initCollection];
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
}

- (void)addFlolder:(NSString *)name {
    if ([_folderHelper addFolder:name]) {
        [Tools showTip:self andMsg:@"添加成功"];

        [self selectAllFolders];

        [self.collectionView reloadData];
    }
    else {
        [Tools showTip:self andMsg:@"添加失败"];
    }
}


- (void)navigationRightBtnClick {
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:true];
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
    }
    else {
        cell.imgFolder.image = [UIImage imageNamed:@"add.png"];
    }
    [cell setName:folder.name];
    return cell;
}

/**
 * 单击单元格
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NoteFolder *folder = [folderList objectAtIndex:indexPath.row];
    // 添加
    if (folder.id == 0) {
        [self showAddDialog];
    }
    else {
        BOOL pSwitch = [UserDefaultsUtils getAppInfoForKeyBool:@"p_switch"];
        NSString *savePwd = [UserDefaultsUtils getAppInfoForKey:@"pwd"];
        // 私密开关开启 并且 设置过密码
        if (pSwitch && ![StringUtils isEmpty:savePwd]) {
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
- (void)showAddDialog {
    FDAlertView *alert = [[FDAlertView alloc] init];
    AddFolderView *contentView = [[NSBundle mainBundle] loadNibNamed:@"AddFolderView" owner:nil options:nil].lastObject;
    [contentView init:self andFrame:CGRectMake(0, 0, 270, 171)];
    alert.contentView = contentView;
    [contentView.edtName becomeFirstResponder];
    [alert show];
}

@end

