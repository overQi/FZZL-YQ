//
//  YQProfileController.m
//  缘圈
//
//  Created by ChainGo on 15/4/29.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "YQProfileController.h"

@interface YQProfileController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *detailInfoM;

@end

@implementation YQProfileController
- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setData];

    [self setUI];
}

- (void)setUI
{
    UIView *nibView = [[NSBundle mainBundle] loadNibNamed:@"YQProfileHeadView" owner:self options:0].firstObject;
    
    self.tableView.tableHeaderView = nibView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setData
{
    [self.detailInfoM addObject:@"个人资料"];
    [self.detailInfoM addObject:@"申请成为服务方"];
    [self.detailInfoM addObject:@"设置"];
    [self.detailInfoM addObject:@"建议反馈"];
    [self.detailInfoM addObject:@"呼叫客服中心"];
}


#pragma mark - Table view data source & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell 重用方式改变
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        // TODO: 添加手势删除cell
        // 1. 判断滑动方向
        // 2. 呼出对应工具栏
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 分割线
        UIView *separatView1 = [[UIView alloc] init];
        separatView1.backgroundColor = [UIColor lightGrayColor];
        separatView1.alpha = 0.6;
        separatView1.width = ScreenWidth;
        separatView1.height = 1;
        separatView1.y = CGRectGetMaxY(cell.frame) - 1;
        [cell.contentView addSubview:separatView1];
        
        UIView *separatView2 = [[UIView alloc] init];
        separatView2.backgroundColor = [UIColor lightGrayColor];
        separatView2.alpha = 0.6;
        separatView2.width = ScreenWidth;
        separatView2.height = 1;
        [cell.contentView addSubview:separatView2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.detailInfoM[indexPath.section];

    //[self addGester: cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = kColor(arc4random() % 255, arc4random() % 255, arc4random() % 255, 1.0);

    [self.navigationController pushViewController:vc animated:YES];
}


// 手势响应一个滑动标签
/*
 - (void)addGester:(UITableViewCell *)cell
 {
 UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellPan:)];
 pan.delegate = self;
 
 [cell addGestureRecognizer:pan];
 }
 
 - (void)cellPan:(UIPanGestureRecognizer *)pan
 {
 //    NSLog(@"%s", __func__);
 }
 
 
 #pragma mark - UIGestureRecognizerDelegate
 -(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
 {
 
 //    NSLog(@"手势移动 %@", NSStringFromCGPoint([gestureRecognizer locationInView:gestureRecognizer.view]));
 return NO;
 }
 
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
 {
 
 NSLog(@"移动中");
 return YES;
 }*/

#pragma mark - 懒加载
- (NSMutableArray *)detailInfoM
{
    if(_detailInfoM == nil)
    {
        _detailInfoM = [NSMutableArray array];
    }
    return _detailInfoM;
}
@end







