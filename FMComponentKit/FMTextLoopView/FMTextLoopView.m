//
//  FMTextLoopView.m
//  FupingElectricity
//
//  Created by mingo on 2019/3/28.
//  Copyright © 2019年 袁凤鸣. All rights reserved.
//
//  Blog：http://www.yfmingo.cn  Email：yfmingo@163.com


#import "FMTextLoopView.h"

@interface FMTextLoopView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger currentRowIndex;
@property (nonatomic, copy) selectTextBlock selectBlock;

@end

@implementation FMTextLoopView

#pragma mark - 初始化方法
+ (instancetype)fm_initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName dataSource:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor selectBlock:(selectTextBlock)selectBlock {
    FMTextLoopView *loopView = [[FMTextLoopView alloc] initWithFrame:frame leftImageName:leftImageName textColor:textColor font:font bgColor:bgColor];
    loopView.dataSource = [NSMutableArray arrayWithArray:dataSource];
    loopView.selectBlock = selectBlock;
    loopView.interval = timeInterval ? timeInterval : 1.0;
    return loopView;
}


-(void)setDataSource:(NSMutableArray *)dataSource {
    if (dataSource == nil) return;
    if (self.tableView) {
        _dataSource = dataSource;
        if (dataSource.count == 1) { /// 如果只有一个数据。就主动加一个同样的数据用于滚动替换。
            id obj = dataSource.firstObject;
            _dataSource = @[obj,obj].mutableCopy;
        }
        self.currentRowIndex = 0;
        [self.tableView reloadData];
    }
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0, tableView.frame.size.width, self.frame.size.height)];
        lbl.tag = 1111;
        lbl.lineBreakMode = NSLineBreakByTruncatingTail;
        lbl.backgroundColor = UIColor.clearColor;
        if (self.textColor) lbl.textColor = self.textColor;
        if (self.font)   lbl.font = self.font;
        [cell.contentView addSubview:lbl];
    }
    cell.backgroundColor = UIColor.clearColor;

    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:1111];
    [lbl setText:_dataSource[indexPath.row]];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock) {
        self.selectBlock(_dataSource[indexPath.row], indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == _dataSource.count) {
        _currentRowIndex = 0;
        [_tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - priviate method
- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    
    // 定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
    _myTimer = timer;
}

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)leftImageName textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor {
    if (self == [super initWithFrame:frame]) {
        CGRect talbeRec;
        CGFloat leftImaW = 35;
        if (leftImageName.length) {
            talbeRec = CGRectMake(leftImaW, 0, frame.size.width - leftImaW, frame.size.height);
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, leftImaW, frame.size.height)];
            [btn setImage:[UIImage imageNamed:leftImageName] forState:0];
            [self addSubview:btn];
        }else{
            talbeRec = CGRectMake(0, 0, frame.size.width, frame.size.height);
        }
        // tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:talbeRec];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = frame.size.height;
        tableView.backgroundColor = UIColor.clearColor;

        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        if (bgColor) {
            self.backgroundColor = bgColor;
        }
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}

- (void)timer {
    self.currentRowIndex++;
//    NSLog(@"%ld", _currentRowIndex);
    [self.tableView setContentOffset:CGPointMake(0, _currentRowIndex * _tableView.rowHeight) animated:YES];
}

-(void)dealloc {
    [_myTimer invalidate];
    _myTimer = nil;
}

@end
