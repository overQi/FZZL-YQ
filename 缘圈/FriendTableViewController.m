//
//  FriendTableViewController.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-27.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "FriendTableViewController.h"
#import "FriendTableViewCell.h"

@interface FriendTableViewController ()

@end

@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 70;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendTableViewCell *cell = [FriendTableViewCell cellWithTableView:tableView];

    return cell;
    
}



@end
