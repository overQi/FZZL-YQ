//
//  MyInfoViewController.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-5-4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "MyInfoViewController.h"
#import "PhotosView.h"

@interface MyInfoViewController ()<UIImagePickerControllerDelegate,PhotosViewDelegate>
@property (nonatomic, strong) NSMutableArray *detailInfoM;
@property (nonatomic, strong) PhotosView *photosView;
@property (nonatomic, strong) NSArray *photos;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
    
}
#pragma mark 自定义
- (void)setupUI
{
    [self.photosView addImage:[UIImage imageNamed:@"jiahao"]];
    [self.photosView addImage:[UIImage imageNamed:@"jiahao"]];
    [self.photosView addImage:[UIImage imageNamed:@"jiahao"]];
    [self.photosView addImage:[UIImage imageNamed:@"jiahao"]];
    
}

- (void)setupData
{
    [self.detailInfoM addObject:@"我的昵称"];
    [self.detailInfoM addObject:@"诚信等级"];
    [self.detailInfoM addObject:@"姓名"];
    [self.detailInfoM addObject:@"性别"];
    [self.detailInfoM addObject:@"手机号"];
    [self.detailInfoM addObject:@"工作"];
    [self.detailInfoM addObject:@"居住"];
    [self.detailInfoM addObject:@"故乡"];
    [self.detailInfoM addObject:@"身份证号"];
}

#pragma mark 图片选择
- (void)showCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

- (void)showImagePicker
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailInfoM.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainWidth, 80.0)];
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel * headerLabel            = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor      = [UIColor clearColor];
    headerLabel.opaque               = NO;
   
    headerLabel.font                 = [UIFont boldSystemFontOfSize:16];
    
    CGFloat headerLabelX = 10.0;
    if(isNotiPhone6Plus){
        headerLabelX = 15.0;
    }else{
        headerLabelX = 20.0;
    }
    headerLabel.frame                = CGRectMake(headerLabelX, 0.0, MainWidth, 80.0);
    headerLabel.text             = @"我的头像";
    
    [customView addSubview:headerLabel];
    
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"testicon.jpg"];
    iconImage.frame = CGRectMake(MainWidth - 70 - 5, 5, 70, 70);
    [iconImage.layer setBorderWidth:1];
    [iconImage.layer setBorderColor:[UIColor blueColor].CGColor];
    iconImage.layer.cornerRadius = iconImage.frame.size.width / 2;
    iconImage.clipsToBounds = YES;
    [customView addSubview:iconImage];
    
    return customView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainWidth, 80.0)];
    customView.backgroundColor = [UIColor whiteColor];
    
    UILabel * footerLabel            = [[UILabel alloc] initWithFrame:CGRectZero];
    footerLabel.backgroundColor      = [UIColor clearColor];
    footerLabel.opaque               = NO;
    
    footerLabel.font                 = [UIFont boldSystemFontOfSize:16];
    
    CGFloat footerLabelX = 10.0;
    if(isNotiPhone6Plus){
        footerLabelX = 15.0;
    }else{
        footerLabelX = 20.0;
    }
    footerLabel.frame                = CGRectMake(footerLabelX, 10, MainWidth, 22.0);

    footerLabel.text                 = @"上传照片";
    [customView addSubview:footerLabel];
    
    
    PhotosView *photosView = [[PhotosView alloc] init];
//    photosView.backgroundColor = [UIColor redColor];
    self.photosView = photosView;
    photosView.delegate = self;
    CGFloat photosX = 0;
    CGFloat photosY = CGRectGetMaxY(footerLabel.frame)+5;
    CGFloat photosW = customView.frame.size.width;
    CGFloat photosH = 70;
    
    photosView.frame = CGRectMake(photosX, photosY, photosW, photosH);
    [customView addSubview:photosView];
    
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyInfoCell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    cell.textLabel.text = self.detailInfoM[indexPath.row];
    cell.detailTextLabel.text = @"测试数据";
    
    return cell;
}

#pragma mark --imagePicker的代理方法
/**无论是照相还是选择照片，完成后都会调用这个方法传递选中的照片,但是不会自动退出*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //退出选择器
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = (UIImage *)info[@"UIImagePickerControllerOriginalImage"];
    [self.photosView addImage:image];
}

#pragma mark photosView 代理
- (void)photosViewClickImageAtIndex:(NSInteger)index
{
    FZ_LOG(@"%ld",index);
}


#pragma mark 懒加载
- (NSMutableArray *)detailInfoM
{
    if(_detailInfoM == nil)
    {
        _detailInfoM = [NSMutableArray array];
    }
    return _detailInfoM;
}

- (NSArray *)photos
{
    if(_photos == nil)
    {
        _photos = [NSArray array];
    }
    return _photos;
}

@end
