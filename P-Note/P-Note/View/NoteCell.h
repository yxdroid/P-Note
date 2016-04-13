//
//  NoteCell.h
//  P-Note
//
//  Created by yaxiongfang on 4/9/16.
//  Copyright © 2016 yxfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@end
