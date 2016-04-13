//
//  EditNoteViewController.h
//  P-Note
//
//  Created by yaxiongfang on 4/9/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import "BaseViewController.h"

@class Note;

@interface EditNoteViewController : BaseViewController

@property int folderId;

@property(nonatomic, strong) Note *note;

@property(weak, nonatomic) IBOutlet UITextView *edtContent;

@property(weak, nonatomic) IBOutlet UITextField *edtTitle;

@end
