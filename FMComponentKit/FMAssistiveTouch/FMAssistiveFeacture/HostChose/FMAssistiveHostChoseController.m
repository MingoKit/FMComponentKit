//
//  FMAssistiveHostChoseController.m
//  Client
//
//  Created by mingo on 2019/10/24.
//  Copyright © 2019 fleeming. All rights reserved.
//

#import "FMAssistiveHostChoseController.h"
#import "FMHostChoseCell.h"
#import "FMFuncItemManager.h"
#import "FMAssistiveTouchManager.h"

static NSString *myTableViewCellID = @"FMHostChoseCell";
#define kFMAssistiveBid [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define kFMAssistiveVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface FMAssistiveHostChoseController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *vv_table;
@property (weak, nonatomic) IBOutlet UITextField *tf_addApi;
@property (weak, nonatomic) IBOutlet UIButton *btn_add;
@property (weak, nonatomic) IBOutlet UILabel *lab_url;
@property (weak, nonatomic) IBOutlet UILabel *lab_bid;
@property (weak, nonatomic) IBOutlet UILabel *lab_version;
@property (weak, nonatomic) IBOutlet UILabel *lab_tip;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lab_environment;

@end

@implementation FMAssistiveHostChoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"接口地址选择";
     [ _btn_add addTarget:self action:@selector(fm_addHost) forControlEvents:UIControlEventTouchUpInside];
    _lab_bid.text = kFMAssistiveBid;
    _lab_version.text = kFMAssistiveVersion;
    
#ifdef DEBUG
    _lab_environment.text = @"Debug 电脑直装版本";

#else
    _lab_environment.text = @"Release 发布版本";
#endif
}

- (void)fm_addHost {
    if (!_tf_addApi.text.length) {
        self.lab_tip.text = @"请输入接口地址！";
        [self fm_addAnimationToView:self.lab_tip];
        return ;
    }
    if (![_tf_addApi.text containsString:@"http"]) {
        self.lab_tip.text = @"输入的地址非法！";
        [self fm_addAnimationToView:self.lab_tip];
        return ;
    }
    NSMutableArray *arr = FMAssistiveTouchManager.shareInstance.getArrHosts.mutableCopy;
    [arr addObject:_tf_addApi.text];
    [FMAssistiveTouchManager.shareInstance setArrHosts:arr];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.vv_table addSubview:self.tableView];
    _lab_url.text = FMAssistiveTouchManager.shareInstance.kMainHost;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.vv_table.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FMHostChoseCell class]) bundle:nil] forCellReuseIdentifier:myTableViewCellID];
        [self.tableView reloadData];
    }
    return _tableView;
}

#pragma mark - tb代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return FMAssistiveTouchManager.shareInstance.getArrHosts.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMHostChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:myTableViewCellID];
    cell.tag = indexPath.row;
    cell.lab01.text = FMAssistiveTouchManager.shareInstance.getArrHosts[indexPath.row];
    cell.delete.tag = indexPath.row;
    [cell.delete addTarget:self action:@selector(fm_delete:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *arr = FMAssistiveTouchManager.shareInstance.getArrHosts.mutableCopy;
    [FMAssistiveTouchManager.shareInstance fm_setkMainHost:arr[indexPath.row]];
    _lab_url.text = FMAssistiveTouchManager.shareInstance.kMainHost;
    FMAssistiveTouchManager.shareInstance.hostChangeBlock(arr[indexPath.row]);
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = arr[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"已复制，当前接口切换为：%@",arr[indexPath.row]];
    self.lab_tip.text = str;
    [self fm_addAnimationToView:self.lab_tip];
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *back = UIView.new;
//    return back;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return self.coinTypeScroll.height;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *back = UIView.new;
//    back.backgroundColor = kGreyColor;
//    return back;
//
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.0;
//}

- (void)fm_delete:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"你要删除该接口环境吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *arr = FMAssistiveTouchManager.shareInstance.getArrHosts.mutableCopy;
        [arr removeObject:arr[sender.tag]];
        [FMAssistiveTouchManager.shareInstance setArrHosts:arr];
        [self.tableView reloadData];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (void)fm_addAnimationToView:(UILabel *)alabel {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.0];     //结束伸缩倍数
    [alabel.layer addAnimation:animation forKey:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        alabel.text = @"";

    });
    
}

@end
