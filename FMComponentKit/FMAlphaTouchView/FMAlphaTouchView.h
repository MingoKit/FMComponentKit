//
//  FMAlphaTouchView.h
//  FupingElectricity
//
//  Created by mingo on 2019/3/10.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef void (^TouchFinishBlock)(BOOL didClick, id objc);

@interface FMAlphaTouchView : UIView
@property (nonatomic ,strong,readonly) UIView *bgView; //遮罩
- (void)fm_addAlphaTouchOnView:(UIView *)backView alpha:(CGFloat)alpha touchFinishBlock:(TouchFinishBlock)touchFinish;
/** 退出 */
-(void)fm_exitClick;
@end
