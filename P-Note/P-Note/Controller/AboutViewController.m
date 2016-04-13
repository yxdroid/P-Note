//
// Created by yaxiongfang on 4/12/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController {
    __weak IBOutlet UITextView *introTv;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距

    NSDictionary *attributes = @{
            NSFontAttributeName : [UIFont systemFontOfSize:15],
            NSParagraphStyleAttributeName : paragraphStyle,
    };
    introTv.attributedText = [[NSAttributedString alloc] initWithString:@"P Note 是一款IOS私密记事APP。用户可以自由的建立分类文件夹， 对记事分类管理。P Note 可以设置私密保护开关，为你的记事添加安全保护。P Note 你值得拥有。" attributes:attributes];
    introTv.textColor = [UIColor lightGrayColor];
}

@end