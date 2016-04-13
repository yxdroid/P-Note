//
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "FolderNoteCell.h"


@implementation FolderNoteCell

- (void)awakeFromNib {

}

- (void)setName:(NSString *)name {
    self.labelName.text = name;
    [self setNeedsLayout];
}

@end