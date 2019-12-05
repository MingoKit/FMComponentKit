//
//  FMAssistiveRequstLogController.m
//  Client
//
//  Created by mingo on 2019/10/24.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMAssistiveRequstLogController.h"
#import "FMAssistiveTouchManager.h"

@interface FMAssistiveRequstLogController ()
@property (weak, nonatomic) IBOutlet UITextView *tx_request;
@property (weak, nonatomic) IBOutlet UIButton *btn_top;
@property (weak, nonatomic) IBOutlet UIButton *btn_down;

@end

@implementation FMAssistiveRequstLogController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tx_request.text = FMAssistiveTouchManager.shareInstance.kRqusetLog;
    [self.tx_request scrollRangeToVisible:NSMakeRange(self.tx_request.text.length, 1)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"请求日志打印";
    self.tx_request.layoutManager.allowsNonContiguousLayout = NO;
    [_btn_down addTarget:self action:@selector(fm_btn_down) forControlEvents:UIControlEventTouchUpInside];
    [_btn_top addTarget:self action:@selector(fm_btn_top) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(fm_btnNavRightAction)];
    self.navigationItem.rightBarButtonItem = barBtn;
 
}

- (void)fm_btn_down {
    [self.tx_request scrollRangeToVisible:NSMakeRange(self.tx_request.text.length, 1)];
}

- (void)fm_btn_top {
    [self.tx_request scrollRangeToVisible:NSMakeRange(0, 1)];
}

- (void)fm_btnNavRightAction {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"您确定要清除吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        FMAssistiveTouchManager.shareInstance.arrRequest = @[].mutableCopy;
        FMAssistiveTouchManager.shareInstance.kRqusetLog = @"网络请求的数据将会打印在这里。";
        self.tx_request.text = FMAssistiveTouchManager.shareInstance.kRqusetLog;
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [self presentViewController:actionSheet animated:YES completion:nil];
}





@end
