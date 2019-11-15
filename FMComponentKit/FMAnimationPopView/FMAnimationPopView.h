//
//  FMAnimationPopView.h
//  FMAnimationPopView <https://github.com/AbnerFM/FMAnimationPopView>
//
//  Created by AbnerFM on 2017/8/12.
//  Copyright © 2017年 AbnerFM. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

/**
 显示时动画弹框样式
 */
typedef NS_ENUM(NSInteger, FMAnimationPopStyle) {
    FMAnimationPopStyleNO = 0,               ///< 无动画
    FMAnimationPopStyleScale,                ///< 缩放动画，先放大，后恢复至原大小
    FMAnimationPopStyleShakeFromTop,         ///< 从顶部掉下到中间晃动动画
    FMAnimationPopStyleShakeFromBottom,      ///< 从底部往上到中间晃动动画
    FMAnimationPopStyleShakeFromLeft,        ///< 从左侧往右到中间晃动动画
    FMAnimationPopStyleShakeFromRight,       ///< 从右侧往左到中间晃动动画
    FMAnimationPopStyleCardDropFromLeft,     ///< 卡片从顶部左侧开始掉落动画
    FMAnimationPopStyleCardDropFromRight,    ///< 卡片从顶部右侧开始掉落动画
};

/**
 移除时动画弹框样式
 */
typedef NS_ENUM(NSInteger, FMAnimationDismissStyle) {
    FMAnimationDismissStyleNO = 0,               ///< 无动画
    FMAnimationDismissStyleScale,                ///< 缩放动画
    FMAnimationDismissStyleDropToTop,            ///< 从中间直接掉落到顶部
    FMAnimationDismissStyleDropToBottom,         ///< 从中间直接掉落到底部
    FMAnimationDismissStyleDropToLeft,           ///< 从中间直接掉落到左侧
    FMAnimationDismissStyleDropToRight,          ///< 从中间直接掉落到右侧
    FMAnimationDismissStyleCardDropToLeft,       ///< 卡片从中间往左侧掉落
    FMAnimationDismissStyleCardDropToRight,      ///< 卡片从中间往右侧掉落
    FMAnimationDismissStyleCardDropToTop,        ///< 卡片从中间往顶部移动消失
};

@interface FMAnimationPopView : UIView

/** 显示时点击背景是否移除弹框，默认为NO。 */
@property (nonatomic) BOOL isClickBGDismiss;
/** 显示时是否监听屏幕旋转，默认为NO */
@property (nonatomic) BOOL isObserverOrientationChange;
/** 显示时背景的透明度，取值(0.0~1.0)，默认为0.5 */
@property (nonatomic) CGFloat popBGAlpha;

/// 动画相关属性参数
/** 显示时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat popAnimationDuration;
/** 隐藏时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat dismissAnimationDuration;
/** 显示完成回调 */
@property (nullable, nonatomic, copy) void(^popComplete)(void);
/** 移除完成回调 */
@property (nullable, nonatomic, copy) void(^dismissComplete)(void);

/**
 通过自定义视图来构造弹框视图
 
 @param customView 自定义视图
 */
- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(FMAnimationPopStyle)popStyle
                               dismissStyle:(FMAnimationDismissStyle)dismissStyle;

/**
 显示弹框
 */
- (void)pop;

/**
 移除弹框
 */
- (void)dismiss;

@end
