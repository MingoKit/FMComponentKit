//
//  FMTextLoopView.h
//  FupingElectricity
//
//  Created by mingo on 2019/3/28.
//  Copyright © 2019年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectTextBlock)(NSString *selectString, NSInteger index);

@interface FMTextLoopView : UIView


/**
 直接调用这个方法
 @param frame 控件大小
 @param leftImageName 左边图标
 @param dataSource 数据源
 @param timeInterval 时间间隔,默认是1.0秒
 @param textColor 文字颜色
 @param font 字体
 @param bgColor  背景色

 */
+ (instancetype)fm_initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName dataSource:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor selectBlock:(selectTextBlock)selectBlock;
/** 更新数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
