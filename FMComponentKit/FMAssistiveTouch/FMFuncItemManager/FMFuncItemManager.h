//
//  FMFuncItemManager.h
//  
//
//  Created by 袁凤鸣 on 2018/3/7.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FMSuspensionView;


#pragma mark ----------FMItemDataModel----------
@interface FMItemDataModel : NSObject

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^Handler)(NSInteger index);

+ (FMItemDataModel *)createModelImage:(UIImage *)iconImage title:(NSString *)title handler:(void(^)(NSInteger index))handler;
@end


#pragma mark ----------FMFuncItemViewModel----------
@interface FMFuncItemViewModel : NSObject
@property (nonatomic, copy) NSArray *dataArray;
#pragma mark - 不加到window上，加到containerView上
- (void)fm_showSuspensionViewToView:(UIView *)containerView;
- (void)fm_showSuspensionViewWithDataArray:(NSArray *)dataArray toView:(UIView *)containerView;
- (FMSuspensionView *)fm_getSuspensionView;
- (void)fm_refreshDataArray:(NSArray *)dataArray;
@end



#pragma mark ----------FMFuncItemManager----------
@interface FMFuncItemManager : NSObject
/***/
@property (nonatomic, copy) NSArray *dataArray;
/** Controller for displaying test items */
@property (nonatomic, weak, readonly) UIViewController *collectionViewController;
+ (instancetype)shareInstance;
/// Display test suspensionView (release mode won't show)
+ (void)showSuspensionView;
+ (void)showSuspensionViewWithDataArray:(NSArray *)dataArray;

///  Remove test suspensionView
+ (void)removeSuspensionView;

+ (FMSuspensionView *)getSuspensionView;

+ (void)hiddenSuspensionView:(BOOL)hidden;

/// 设置数据源
+ (void)setupItemDataArray:(NSArray *)array;

/// Close test list
+ (void)closeCollectionViewController;
+ (void)closeCollectionViewControllerWithCompletion:(void(^)(id objc))completion;


@end
