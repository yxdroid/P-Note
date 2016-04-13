//
// Created by yaxiongfang on 4/7/16.
// Copyright (c) 2016 yxfang. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;

/**
 * 初始化数据
 */
- (void)initData;

/**
 * 添加分类目录
 */
-(void) addFlolder:(NSString *)name;

@end

