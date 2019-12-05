//
//  FMCollectionViewController.h
//  
//
//  Created by 袁凤鸣 on 2018/3/7.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMFuncItemManager.h"



#pragma mark ----------FMFuncItemCollectionViewCell----------
@interface FMFuncItemCollectionViewCell : UICollectionViewCell

- (void)configCellWithData:(FMItemDataModel *)data;

@end



#pragma mark ----------FMCollectionViewController----------
static NSString *const kYBFuncItemCollectionViewControllerKey = @"kYBFuncItemCollectionViewControllerKey";

@interface FMCollectionViewController : UIViewController
@property (nonatomic, strong) NSArray *dataArray;
- (void)refresh;
@end
