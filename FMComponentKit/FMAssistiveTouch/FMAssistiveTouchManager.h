//
//  FMAssistiveTouchManager.h
//  Client
//
//  Created by mingo on 2019/12/5.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FMFuncHostChangeBlock)(id objc);
@interface FMAssistiveTouchManager : NSObject 
/// 当前选中的 host 地址
@property (nonatomic, copy) NSString *kMainHost;
/// 当前 host 变化 时 回调
@property (nonatomic, copy) FMFuncHostChangeBlock hostChangeBlock;
/// 组装好的请求数据字符串
@property (nonatomic, strong) NSString *kRqusetLog;
/// 储存 请求数据 的数据源 （正常直接使用 kRqusetLog 即可）
@property (nonatomic, strong) NSMutableArray <NSString *>*arrRequest;
/// 保存多少组请求日志 【默认： 20组】
@property (nonatomic, assign) NSInteger requestMaxTimes;
/// 是否开启过调试入口
@property (nonatomic, assign) BOOL showAssistiveTouch;

+ (instancetype)shareInstance;

/// 在某个视图上新增调试入口
- (void)fm_addTapEnterForView:(UIView *)view;
/// 新增请求日志数据到数据源
- (void)fm_addObjectToArrRequested:(id)objc;
/// 显示调试器动态按钮
- (void)fm_showSuspension;



/// 获取 host 接口地址集合
- (NSMutableArray *)getArrHosts;
/// 设置 host 接口地址集合
- (void)setArrHosts:(NSMutableArray *)arrHosts;

- (void)fm_setkMainHost:(NSString *)kMainHost;
@end

NS_ASSUME_NONNULL_END
