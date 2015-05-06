//
//  TempController.m
//  缘圈
//
//  Created by ChainGo on 15/5/5.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "TempController.h"

@interface TempController ()

@end

@implementation TempController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView
{
    UILabel *labelA = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 150, 43)];
    labelA.lineBreakMode = UILineBreakModeWordWrap;
    labelA.numberOfLines = 0;
    [labelA setTextAlignment:UITextAlignmentCenter];
    [labelA setBackgroundColor:[UIColor clearColor]];
    labelA.text = @"ABCDEFGHIJ";
    
    UISegmentedControl *mySegment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@" ",@" ",@" ",nil]];
    [mySegment setFrame:CGRectMake(10, 150, 300, 43)];
    [mySegment setSelectedSegmentIndex:0];
    
    [self.view addSubview:mySegment];
    [self.view addSubview:labelA];
    
    [self.view sendSubviewToBack:mySegment];
}

@end















