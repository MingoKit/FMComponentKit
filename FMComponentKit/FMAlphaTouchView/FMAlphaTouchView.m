//
//  FMAlphaTouchView.m
//  FupingElectricity
//
//  Created by mingo on 2019/3/10.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import "FMAlphaTouchView.h"

@interface FMAlphaTouchView (){
}
@property (nonatomic ,strong) UIView *bgView; //遮罩
@property (nonatomic ,strong) UIView *objBackView;
@property (nonatomic ,assign) CGFloat alpha;
@property(nonatomic, strong) TouchFinishBlock touchFinish;


@end

@implementation FMAlphaTouchView

- (void)fm_addAlphaTouchOnView:(UIView *)backView alpha:(CGFloat)alpha touchFinishBlock:(TouchFinishBlock)touchFinish{
    if (!backView) {
        return;
    }
    self.touchFinish = touchFinish;
    self.objBackView = backView;
    self.alpha = alpha;
    [self addBgView];

}

- (void)addBgView {
    
    
    self.bgView                 = [[UIView alloc] init];
    self.bgView.frame           = self.objBackView.bounds;
    self.frame = self.objBackView.bounds;
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.alpha];
    self.bgView.opaque = NO;
    self.bgView.hidden = YES;
    [self addSubview:self.bgView];
    //--UIWindow的优先级最高，Window包含了所有视图，在这之上添加视图，可以保证添加在最上面
    [self.objBackView addSubview:self];
    // ------给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fm_touchClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.bgView addGestureRecognizer:gesture];
    [self fm_PopShow];
}

//弹出
-(void)fm_PopShow{
    __weak typeof(self)weakSelf = self;

    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.hidden = NO;

        if (self.touchFinish) {
            self.touchFinish(NO,weakSelf);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
        } ];
        
    }];
    
}

-(void)fm_touchClick{
    __weak typeof(self)weakSelf = self;
    if (self.touchFinish) {
        [self endEditing:YES];
        self.touchFinish(YES,weakSelf);
    }
}


/** 退出 */
-(void)fm_exitClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        self.touchFinish = nil;
    }completion:^(BOOL finished) {
       
        [UIView animateWithDuration:0.5 animations:^{
        }];
    }];
}

@end
