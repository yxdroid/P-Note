//
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FolderNoteCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgFolder;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *ivPrivate;

- (void)setName:(NSString *)name;

@end