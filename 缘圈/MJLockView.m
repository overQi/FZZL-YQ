//
//  MJLockView.m
//  03-手势解锁
//
//  Created by apple on 14-4-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJLockView.h"
#import "MJCircleView.h"
#import "DeviceMacros.h"
#import "HP_Common4IOS.h"

@interface MJLockView()
@property (nonatomic, strong) NSMutableArray *selectedButtons;
@property (nonatomic, assign) CGPoint currentMovePoint;
@property (nonatomic, assign, readwrite) NSInteger currentSelectedBtnNumber;


@end

@implementation MJLockView

#pragma mark - 初始化
- (NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}


/**
 初始化
 */
- (void)setup
{
//    self.backgroundColor = [UIColor clearColor];
    
    for (int index = 0; index<kButtonNumber; index++) {
        // 创建按钮
        MJCircleView *btn = [MJCircleView buttonWithType:UIButtonTypeCustom];
        btn.tag           = index;
        
        // 添加按钮
        [self addSubview:btn];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    MJCircleView *btnTop    = self.subviews[0];
    MJCircleView *btnLeft   = self.subviews[1];
    MJCircleView *btnBottom = self.subviews[2];
    MJCircleView *btnRight  = self.subviews[3];
    CGFloat mainWidth  = self.frame.size.width;
    CGFloat mainHeight = self.frame.size.height;
    CGFloat btnW = kButtonSize.width;
    CGFloat btnH = kButtonSize.height;
    
    btnTop.frame    = CGRectMake(mainWidth/2 - btnW/2, 0, btnW, btnH);
    btnLeft.frame   = CGRectMake(0,  mainHeight/2-btnH/2, btnW, btnH);
    btnBottom.frame = CGRectMake(mainWidth/2 - btnW/2, mainHeight-btnH, btnW, btnH);
    btnRight.frame  = CGRectMake(mainWidth - btnW, mainHeight/2-btnH/2, btnW, btnH);
    
    
    // 设置默认的背景图片
    [btnTop setBackgroundImage:[UIImage imageNamed:[NSString addPrefix:[NSDate isDayOrNight] withString:@"滑动按钮-01"]] forState:UIControlStateNormal];
    [btnTop setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    
    [btnLeft setBackgroundImage:[UIImage imageNamed:[NSString addPrefix:[NSDate isDayOrNight] withString:@"滑动按钮-02"]] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    
    [btnBottom setBackgroundImage:[UIImage imageNamed:[NSString addPrefix:[NSDate isDayOrNight] withString:@"滑动按钮-04"]] forState:UIControlStateNormal];
    [btnBottom setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    
    [btnRight setBackgroundImage:[UIImage imageNamed:[NSString addPrefix:[NSDate isDayOrNight] withString:@"滑动按钮-03"]] forState:UIControlStateNormal];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    
    
}

#pragma mark - 私有方法
/**
 根据touches集合获得对应的触摸点位置
 */
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

/**
 根据触摸点位置获得对应的按钮
 */
- (MJCircleView *)buttonWithPoint:(CGPoint)point
{
    for (MJCircleView *btn in self.subviews) {
        
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    
    return nil;
}

#pragma mark - 触摸方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 清空当前的触摸点
    self.currentMovePoint = CGPointZero;
    
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮
    MJCircleView *btn = [self buttonWithPoint:pos];
    
    // 3.设置状态
    if (btn && (btn.selected == NO) && self.selectedButtons.count < kMaxSelectedBtnNumber) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮
    MJCircleView *btn = [self buttonWithPoint:pos];
    
    // 3.设置状态
    if (btn && (btn.selected == NO) && self.selectedButtons.count < kMaxSelectedBtnNumber) { // 摸到了按钮
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    } else { // 没有摸到按钮
        self.currentMovePoint = pos;
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (MJCircleView *btn in self.selectedButtons) {
            [path appendFormat:@"%ld", btn.tag];
            btn.selected = NO;
        }
        [self.delegate lockView:self didFinishPath:path];
    }
    
    // 取消选中所有的按钮
    
    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    // 清空选中的按钮
    [self.selectedButtons removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect
{
    if (self.selectedButtons.count == 0 ) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 遍历所有的按钮
    for (int index = 0; index<self.selectedButtons.count; index++) {
        MJCircleView *btn = self.selectedButtons[index];
        
        if (index == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 连接
    if (CGPointEqualToPoint(self.currentMovePoint, CGPointZero) == NO) {
        if( !(self.selectedButtons.count >= kMaxSelectedBtnNumber)){
            [path addLineToPoint:self.currentMovePoint];
        }
    }
    
    // 绘图
    path.lineWidth = kLineWidth;
    path.lineJoinStyle = kCGLineJoinBevel;
    [kLineColor set];
    [path stroke];
}

@end

