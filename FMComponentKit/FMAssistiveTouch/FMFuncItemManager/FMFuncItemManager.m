//
//  FMFuncItemManager.m
//  
//
//  Created by 袁凤鸣 on 2018/3/7.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "FMFuncItemManager.h"
#import "FMSuspensionView.h"
#import "FMSuspensionManager.h"
#import "FMCollectionViewController.h"

#pragma mark ----------FMItemDataModel----------
@implementation FMItemDataModel
+ (FMItemDataModel *)createModelImage:(UIImage *)iconImage title:(NSString *)title handler:(void (^)(NSInteger))handler {
    FMItemDataModel *dataModel = [[FMItemDataModel alloc]init];
    dataModel.iconImage = iconImage;
    dataModel.title = title;
    dataModel.Handler = handler;
    
    return dataModel;
}

@end

#pragma mark ----------FMFuncItemViewModel----------

@interface FMFuncItemViewModel ()<FMSuspensionViewDelegate>

@property (nonatomic, weak) FMSuspensionView *susView;
@end
@implementation FMFuncItemViewModel

CGFloat suspensionView_w_h = 35;
extern CGFloat suspensionViewAlpha;

//pragma mark - 不加到window上，加到containerView上
- (void)fm_showSuspensionViewToView:(UIView *)containerView {
    CGFloat margin = 30;
    //origin.x可用[FMSuspensionView suggestXWithWidth:100]方法
    FMSuspensionView *susView = [[FMSuspensionView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - margin/2 - suspensionView_w_h, [UIScreen mainScreen].bounds.size.height/2 , suspensionView_w_h, suspensionView_w_h) color:[UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00] delegate:self];
    susView.leanType = FMSuspensionViewLeanTypeEachSide;
    susView.cancelMove = NO;
    susView.layer.cornerRadius = suspensionView_w_h/2;
    susView.alpha = 1.;
//    susView.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 3.5, 0);
    [susView setTitle:@"🍏" forState:UIControlStateNormal];
    susView.titleLabel.font = [UIFont systemFontOfSize:18];
    susView.addedWindow = NO;
    [containerView addSubview:susView];
    [susView setAnimation:YES];
    self.susView = susView;
    
}

- (void)suspensionViewClick:(FMSuspensionView *)suspensionView {
    if ([FMSuspensionManager windowForKey:kYBFuncItemCollectionViewControllerKey]) {
        [FMSuspensionManager destroyWindowForKey:kYBFuncItemCollectionViewControllerKey];
    }else{
        UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
        FMCollectionViewController *collectionViewVC = [[FMCollectionViewController alloc] init];
        FMSuspensionContainer *window = [[FMSuspensionContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = collectionViewVC;
        window.windowLevel -= 1;
        [window makeKeyAndVisible];
        [FMSuspensionManager saveWindow:window forKey:kYBFuncItemCollectionViewControllerKey];
        [currentKeyWindow makeKeyWindow];
        collectionViewVC.dataArray = self.dataArray;
    }
}

- (void)fm_showSuspensionViewWithDataArray:(NSArray *)dataArray toView:(UIView *)containerView {
    [self fm_showSuspensionViewToView:containerView];
    self.dataArray = dataArray;
}

- (FMSuspensionView *)fm_getSuspensionView {
    return self.susView;
}

- (void)fm_refreshDataArray:(NSArray *)dataArray {
    self.dataArray = dataArray;
}

@end

#pragma mark ----------FMFuncItemManager----------
static NSString *keynameArrHosts = @"keynameArrHosts";
static NSString *keynamekMainHost = @"keynamekMainHost";
static NSString *keynameShowAssistiveTouch = @"keynameShowAssistiveTouch";
@interface FMFuncItemManager ()<FMSuspensionViewDelegate>

@property (nonatomic, weak) FMSuspensionView *susView;
@property (nonatomic, weak, nullable) UIViewController *collectionViewController;

@end

@implementation FMFuncItemManager

static FMFuncItemManager *_instance;

+ (instancetype)shareInstance {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[FMFuncItemManager alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - API
+ (void)showSuspensionView {
    if ([FMFuncItemManager shareInstance].susView) {
        [[FMFuncItemManager shareInstance].susView removeFromScreen];
    }
    CGFloat margin = 30;
    //origin.x可用[FMSuspensionView suggestXWithWidth:100]方法
    FMSuspensionView *susView = [[FMSuspensionView alloc] initWithFrame:CGRectMake( [FMSuspensionView suggestXWithWidth:margin],[UIScreen mainScreen].bounds.size.height/2, suspensionView_w_h, suspensionView_w_h) color:[UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00] delegate:[FMFuncItemManager shareInstance]];
    susView.leanType = FMSuspensionViewLeanTypeEachSide;
    susView.cancelMove = NO;
    susView.alpha = suspensionViewAlpha;
    susView.addedWindow = YES;//💣😂🍏♣️🛠🎮🐶👁‍🗨🥶👿👿
    //[susView setImage:[UIImage imageNamed:@"assistive_bg_image"] forState:UIControlStateNormal];
    [susView setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [susView setTitle:@"🍏" forState:UIControlStateNormal];
    [susView show];
    [susView setAnimation:YES];
    [FMFuncItemManager shareInstance].susView = susView;
}

+ (void)showSuspensionViewWithDataArray:(NSArray *)dataArray {
    [self showSuspensionView];
    
    [self setupItemDataArray:dataArray];
}

+ (FMSuspensionView *)getSuspensionView {
    return [FMFuncItemManager shareInstance].susView;
}

+ (void)removeSuspensionView {
    [[FMFuncItemManager shareInstance].susView removeFromScreen];
    [FMFuncItemManager shareInstance].susView = nil;
}

+ (void)hiddenSuspensionView:(BOOL)hidden {
    [[FMFuncItemManager shareInstance].susView hiddenFromScreen:hidden];
}

+ (void)setupItemDataArray:(NSArray *)array {
    [FMFuncItemManager shareInstance].dataArray = array;
}

+ (void)closeCollectionViewController {
    [FMSuspensionManager destroyWindowForKey:kYBFuncItemCollectionViewControllerKey];
    [FMFuncItemManager shareInstance].collectionViewController = nil;
    if ([FMFuncItemManager shareInstance].susView.isAddedWindow) {
        [FMFuncItemManager shareInstance].susView.alpha = suspensionViewAlpha;
    }else {
        [FMFuncItemManager shareInstance].susView.alpha = 1.;
    }
}

+ (void)closeCollectionViewControllerWithCompletion:(void(^)(id objc))completion {
    UIWindow *win = [FMSuspensionManager windowForKey:kYBFuncItemCollectionViewControllerKey];
    CGRect rect = win.frame;
    rect.origin.y = [UIApplication sharedApplication].keyWindow.bounds.size.height;
    [UIView animateWithDuration:.1 animations:^{
        win.frame = rect;
    } completion:^(BOOL finished) {
        [FMSuspensionManager destroyWindowForKey:kYBFuncItemCollectionViewControllerKey];
        [FMFuncItemManager shareInstance].collectionViewController = nil;
        if ([FMFuncItemManager shareInstance].susView.isAddedWindow) {
            [FMFuncItemManager shareInstance].susView.alpha = suspensionViewAlpha;
        }else {
            [FMFuncItemManager shareInstance].susView.alpha = 1.;
        }
        if (completion) {
            completion(nil);
        }
    }];
}

#pragma mark - FMSuspensionViewDelegate
- (void)suspensionViewClick:(FMSuspensionView *)suspensionView {
    if ([FMSuspensionManager windowForKey:kYBFuncItemCollectionViewControllerKey]) {
        [FMSuspensionManager destroyWindowForKey:kYBFuncItemCollectionViewControllerKey];
        [FMFuncItemManager shareInstance].collectionViewController = nil;
    }else{
        UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
        FMCollectionViewController *collectionViewVC = [[FMCollectionViewController alloc] init];
        FMSuspensionContainer *window = [[FMSuspensionContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = collectionViewVC;
        window.windowLevel -= 1;
        [window makeKeyAndVisible];
        [FMSuspensionManager saveWindow:window forKey:kYBFuncItemCollectionViewControllerKey];
        [currentKeyWindow makeKeyWindow];
        [FMFuncItemManager shareInstance].collectionViewController = collectionViewVC;
        
        if ([FMFuncItemManager shareInstance].susView && ![FMFuncItemManager shareInstance].susView.isAddedWindow) {
            collectionViewVC.dataArray = [FMFuncItemManager shareInstance].susView.dataArray;
        }else {
            [collectionViewVC refresh];
        }
        
    }
    if ([[[FMFuncItemManager shareInstance].susView.superview class] isKindOfClass:[FMSuspensionContainer class]]) {
        [FMFuncItemManager shareInstance].susView.alpha = suspensionViewAlpha;
    }else {
        [FMFuncItemManager shareInstance].susView.alpha = 1;
    }
    
}

@end
