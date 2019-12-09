//
//  FMAssistiveTouchManager.m
//  Client
//
//  Created by mingo on 2019/12/5.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMAssistiveTouchManager.h"
#import "FMFuncItemManager.h"

#pragma mark ----------FMFuncItemManager----------
static NSString *keynameArrHosts = @"keynameArrHosts";
static NSString *keynamekMainHost = @"keynamekMainHost";
static NSString *keynameShowAssistiveTouch = @"keynameShowAssistiveTouch";
@interface FMAssistiveTouchManager (){
    /// 选择接口 host 的数组
    NSMutableArray <NSString *>* _arrHosts;
}

@property (nonatomic, weak) FMSuspensionView *susView;
@property (nonatomic, weak, nullable) UIViewController *collectionViewController;
/// 点击次数
@property (nonatomic, assign) NSInteger tapTimes;

@end
static FMAssistiveTouchManager *_instance;


@implementation FMAssistiveTouchManager
+ (instancetype)shareInstance {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[FMAssistiveTouchManager alloc] init];
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

- (NSMutableArray *)getArrHosts{
    _arrHosts = @[].mutableCopy;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSMutableArray *name = [userDefaults objectForKey:keynameArrHosts];
    if (name.count) {
        _arrHosts = [NSMutableArray arrayWithArray:name];
    }
    return _arrHosts;
}

- (void)setArrHosts:(NSMutableArray *)arrHosts {
    _arrHosts = arrHosts;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:arrHosts forKey:keynameArrHosts];
    [userDefaults synchronize];
}
- (NSInteger)requestMaxTimes {
    if (_requestMaxTimes <= 0) {
        _requestMaxTimes = 20;
    }
    return _requestMaxTimes;
}

- (NSMutableArray *)arrRequest{
    if (!_arrRequest) {
        _arrRequest =[[NSMutableArray alloc] initWithCapacity:20];
    }
    return _arrRequest;
}

- (void)fm_addObjectToArrRequested:(id)objc {
    [self.arrRequest addObject:objc];
    if (self.arrRequest.count >= self.requestMaxTimes) {
        [self.arrRequest removeObjectAtIndex:0];
    }
}

-(NSString *)kRqusetLog {
    _kRqusetLog = [self.arrRequest debugDescription] ;

    return _kRqusetLog;
}

//用po打印调试信息时会调用该方法
- (NSString *)debugDescription{
    NSError *error = nil;
    //字典转成json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.arrRequest options:NSJSONWritingPrettyPrinted  error:&error];
    //如果报错了就按原先的格式输出
    if (error) {
        return [super debugDescription];
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


-(NSString *)kMainHost {
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:keynamekMainHost];
    _kMainHost = self.getArrHosts.firstObject;
    if (name.length) {
        _kMainHost = name;
    }
    return  _kMainHost;
}

- (void)fm_setkMainHost:(NSString *)kMainHost {
    if (!kMainHost.length) {
        return;
    }
    _kMainHost = kMainHost;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setValue:kMainHost forKey:keynamekMainHost];
    [userDefaults synchronize];
}

-(BOOL)showAssistiveTouch {
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    BOOL name = [userDefaults boolForKey:keynameShowAssistiveTouch];
    _showAssistiveTouch = name;
    return _showAssistiveTouch;
}

- (void)fm_addTapEnterForView:(UIView *)view {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fm_clickEvent)];
    tap.numberOfTouchesRequired = 1;
    [view addGestureRecognizer: tap];
}

- (void)fm_clickEvent {
    if (self.tapTimes == 8) {
        self.tapTimes = 0;
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        BOOL flag = FMAssistiveTouchManager.shareInstance.showAssistiveTouch;
        if (flag) {
            flag = NO;
        }else{
            flag = YES;
        }
        [userDefaults setBool:flag forKey:keynameShowAssistiveTouch];
        [userDefaults synchronize];
        if (FMAssistiveTouchManager.shareInstance.showAssistiveTouch) {
            [self fm_showSuspension];
        }else{
            [FMFuncItemManager removeSuspensionView];
        }
    }
    self.tapTimes++;
}

- (void)fm_showSuspension {
    NSMutableArray *mutArr = [NSMutableArray array];
    NSMutableArray *arrTitles = @[@"接口环境切换",@"请求日志打印"].mutableCopy;
    for (int i = 0; i<arrTitles.count; i++) {
        FMItemDataModel *model = [FMItemDataModel createModelImage:nil title:arrTitles[i] handler:^(NSInteger index) {
            NSLog(@"点击了第%ld个",(long)index);
            switch (index) {
                case 0: {
                    UIViewController *vc = [[NSClassFromString(@"FMAssistiveHostChoseController") alloc] init];
                    [[self fm_getCurrentViewController].navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1: {
                    UIViewController *vc = [[NSClassFromString(@"FMAssistiveRequstLogController") alloc] init];
                    [[self fm_getCurrentViewController].navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
        [mutArr addObject:model];
    }
    //    [self.itemTool fm_showSuspensionViewWithDataArray:mutArr toView:self.view];
    [FMFuncItemManager showSuspensionViewWithDataArray:mutArr.copy];
}



#pragma mark - 获取当前屏幕显示的VC
- (UIViewController *)fm_getCurrentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }else if([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }else{
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
