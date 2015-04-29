//
//  SelectMapViewController.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-29.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "SelectMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DXPopover.h"
#import "HP_NavigationController.h"


@interface SelectMapViewController ()<UISearchBarDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic, readwrite) UISearchBar *searchBar;
@property (nonatomic, strong, readwrite) CLLocationManager *locationMgr;
@property (strong, nonatomic, readwrite) MKMapView *mapView;
@property (nonatomic, strong           ) UITableView *searchHistoryTableView;//历史记录tableView
@end

@implementation SelectMapViewController
#pragma mark 初始化
- (UISearchBar *)searchBar
{
    if(_searchBar == nil)
    {
        _searchBar = [[UISearchBar alloc] init];
    }
    return _searchBar;
}

- (MKMapView *)mapView
{
    if(_mapView == nil)
    {
        _mapView = [[MKMapView alloc] init];
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    self.mapView.frame            = self.view.frame;
    self.locationMgr              = [[CLLocationManager alloc] init];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate         = self;
    
    
    self.locationMgr                 = [[CLLocationManager alloc]init];
    self.locationMgr.delegate        = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter  = 20.0;    //移动忽略距离
    [self.locationMgr startUpdatingLocation];
    //ios8弹出提示框
    if(IOS8){
        [self.locationMgr requestWhenInUseAuthorization];
    }
    [self.view addSubview:self.mapView];
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, 40)];
    self.searchBar.placeholder=@"请输入地址";
    self.searchBar.delegate           = self;
    self.searchBar.showsCancelButton  = YES;
    self.searchBar.keyboardType       = UIKeyboardTypeDefault;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview: self.searchBar];
    
    self.searchHistoryTableView    = [[UITableView alloc] init];
    self.searchHistoryTableView.frame           = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), MainWidth, MainHeight - self.searchBar.frame.size.height);
    self.searchHistoryTableView.backgroundColor = [UIColor colorWithWhite:0.435 alpha:0.690];
    self.searchHistoryTableView.delegate        = self;
    self.searchHistoryTableView.dataSource      = self;
    self.searchHistoryTableView.hidden          = YES;
    [self.view addSubview:self.searchHistoryTableView];
    
    //键盘呼出或者隐藏时，对历史记录tableView做相应操作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    self.title = @"地图";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClick)];
}

- (void)setupData
{
    
}

- (void)keyBoardWillShow
{
    self.searchHistoryTableView.hidden = NO;
    [self.searchHistoryTableView reloadData];
}

- (void)keyBoardWillHide
{
    self.searchHistoryTableView.hidden = YES;
}

- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark searchBar代理
//点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];

}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
}

//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

#pragma mark tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"historyCell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text      = [NSString stringWithFormat:@"测试数据%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.872 alpha:1.000];
    cell.backgroundColor     = [UIColor clearColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchHistoryTableView){
        
        self.searchBar.text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.searchBar endEditing:YES];
    }
}

#pragma mark - MKMapViewDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationMgr requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

/**
 *  当用户的位置更新，就会调用（不断地监控用户的位置，调用频率特别高）
 *
 *  @param userLocation 表示地图上蓝色那颗大头针的数据
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"您的位置";
    userLocation.subtitle = @"您当前所在位置";
    
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    FZ_LOG(@"%f %f", center.latitude, center.longitude);
    
    // 设置地图的中心点（以用户所在的位置为中心点）
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图的显示范围
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    [mapView setRegion:region animated:YES];
}

//回到用户位置
- (void)backToUserLocation {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}
@end
