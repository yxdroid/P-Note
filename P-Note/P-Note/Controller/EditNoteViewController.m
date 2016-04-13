//
//  EditNoteViewController.m
//  P-Note
//
//  Created by yaxiongfang on 4/9/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import "EditNoteViewController.h"
#import "NoteHelper.h"
#import "Note.h"

@implementation EditNoteViewController {
    NoteHelper *_noteHelper;

    // 标识是否是编辑
    BOOL isEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [super setNavigationRightBtn:[[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                 target:self action:@selector(navigationRightBtnClick)]];

    // 编辑模式
    if (_note != nil) {
        _edtTitle.text = _note.title;
        _edtContent.text = _note.content;
        [super setTitle:_note.title];

        isEdit = YES;
    }
    else {
        [super setTitle:@"添加笔记"];
        isEdit = NO;
    }
}

- (void)navigationRightBtnClick {
    NSString *title = _edtTitle.text;
    NSString *content = _edtContent.text;

    if ([StringUtils isEmpty:title]) {
        [Tools showTip:self andMsg:@"请输入标题"];
        return;
    }

    if ([StringUtils isEmpty:content]) {
        [Tools showTip:self andMsg:@"请输入笔记"];
        return;
    }

    if (_noteHelper == nil) {
        _noteHelper = [[NoteHelper alloc] init];
    }

    if (isEdit) {
        if ([_noteHelper updateNote:title andContent:content andFolderId:_note.id]) {
            [Tools showTip:self andMsg:@"保存成功"];
            [_edtTitle resignFirstResponder];
            [_edtContent resignFirstResponder];

            // 修改成功 发送更新列表通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNoteList" object:nil];
        }
        else {
            [Tools showTip:self andMsg:@"保存失败"];
        }
    }
    else {
        if ([_noteHelper addNote:title andContent:content andFolderId:_folderId]) {
            [Tools showTip:self andMsg:@"保存成功"];
            [_edtTitle resignFirstResponder];
            [_edtContent resignFirstResponder];

            // 添加成功 发送更新列表通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNoteList" object:nil];

            _edtTitle.text = @"";
            _edtContent.text = @"";
        }
        else {
            [Tools showTip:self andMsg:@"保存失败"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
