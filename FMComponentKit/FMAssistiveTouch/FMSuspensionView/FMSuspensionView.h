//
//  FMSuspensionView.h
//  FMSuspensionView
//
//  GitHub  
//  Created by wangyingbo on 16-02-25.
//  Copyright (c) 2016年 wangyingbo. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark ----------FMSuspensionContainer----------
@interface FMSuspensionContainer : UIWindow
@end

#pragma mark ----------FMSuspensionViewController----------
@interface FMSuspensionViewController : UIViewController
@end

#pragma mark ----------FMSuspensionViewDelegate----------
@class FMSuspensionView;
@protocol FMSuspensionViewDelegate <NSObject>
/** callback for click on the FMSuspensionView */
- (void)suspensionViewClick:(FMSuspensionView *)suspensionView;
@end


/**
 可移动的方向
 */
typedef NS_ENUM(NSUInteger, FMSuspensionViewLeanType) {
    /** Can only stay in the left and right */
    FMSuspensionViewLeanTypeHorizontal,
    /** Can stay in the upper, lower, left, right */
    FMSuspensionViewLeanTypeEachSide
};


@interface FMSuspensionView : UIButton

/** 是否取消移动 */
@property (nonatomic, assign, getter=isCancelMove) BOOL cancelMove;
@property (nonatomic, assign, getter=isAddedWindow) BOOL addedWindow;
@property (nonatomic, copy) NSArray *dataArray;


/** delegate */
@property (nonatomic, weak) id<FMSuspensionViewDelegate> delegate;
/** lean type, default is FMSuspensionViewLeanTypeHorizontal */
@property (nonatomic, assign) FMSuspensionViewLeanType leanType;
/** container window */
@property (nonatomic, readonly) FMSuspensionContainer *containerWindow;

/**
 Create a default susView

 @param delegate delegate for susView
 @return obj
 */
+ (instancetype)defaultSuspensionViewWithDelegate:(id<FMSuspensionViewDelegate>)delegate;

/** Get the suggest x with width */
+ (CGFloat)suggestXWithWidth:(CGFloat)width;

/**
 Create a susView

 @param frame frame
 @param color background color
 @param delegate delegate for susView
 @return obj
 */
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<FMSuspensionViewDelegate>)delegate;

/**
 *  Show
 */
- (void)show;

/**
 *  Remove and dealloc
 */
- (void)removeFromScreen;

- (void)hiddenFromScreen:(BOOL)hidden;

/**
 设置动画

 @param animation animation description
 */
- (void)setAnimation:(BOOL)animation;

@end


