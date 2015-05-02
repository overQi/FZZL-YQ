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
#import "MBProgressHUD+HP.h"


@interface SelectMapViewController ()<UISearchBarDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readwrite) IBOutlet UISearchBar       *searchBar;
@property (nonatomic, strong, readwrite) IBOutlet MKMapView         *mapView;
@property (nonatomic, strong, readwrite) IBOutlet UITableView       *searchHistoryTableView;//历史记录tableView
@property (nonatomic, strong, readwrite) IBOutlet UIView            *contentView;//容器View。包装searchBar和MapView实现动画上移效果
@property (weak, nonatomic) IBOutlet UIView *buttomTabBar;
@property (weak, nonatomic) IBOutlet UILabel *tabBarLabel;

@property (nonatomic, strong, readwrite) NSMutableArray *alternativeAddressesM;	//备选目的地
@property (nonatomic, strong, readwrite) NSMutableArray *historyAddressM;		//历史搜索地址
@property (nonatomic, strong, readwrite) CLLocationManager *locationMgr;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong, readwrite) MKUserLocation *userLocation;
- (IBAction)tabBarConfirmBtnClick:(UIButton *)sender;
@end

@implementation SelectMapViewController
#pragma mark 初始化

- (NSMutableArray *)alternativeAddressesM
{
	if(_alternativeAddressesM == nil)
	{
		_alternativeAddressesM = [NSMutableArray array];
	}
	return _alternativeAddressesM;
}
- (NSMutableArray *)historyAddressM
{
	if(_historyAddressM == nil)
	{
		_historyAddressM = [NSMutableArray array];
	}
	return _historyAddressM;
}

- (CLGeocoder *)geocoder
{
	if (!_geocoder) {
		self.geocoder = [[CLGeocoder alloc] init];
	}
	return _geocoder;
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

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI
{
    self.locationMgr              = [[CLLocationManager alloc] init];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate         = self;
	
    [self.contentView addSubview:self.mapView];
	
    self.locationMgr                 = [[CLLocationManager alloc]init];
    self.locationMgr.delegate        = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter  = 20.0;    //移动忽略距离
    [self.locationMgr startUpdatingLocation];
    //ios8弹出提示框
    if(IOS8){
        [self.locationMgr requestWhenInUseAuthorization];
    }
	

    self.searchBar.placeholder=@"请输入地址";
    self.searchBar.delegate           = self;
    self.searchBar.showsCancelButton  = YES;
    self.searchBar.keyboardType       = UIKeyboardTypeDefault;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	
    [self.contentView addSubview: self.searchBar];
	
    self.searchHistoryTableView.frame           = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), MainWidth, MainHeight - self.searchBar.frame.size.height);
    self.searchHistoryTableView.backgroundColor = [UIColor colorWithWhite:0.435 alpha:0.690];
    self.searchHistoryTableView.delegate        = self;
    self.searchHistoryTableView.dataSource      = self;
    self.searchHistoryTableView.hidden          = YES;
    [self.contentView addSubview:self.searchHistoryTableView];
	
	
    //键盘呼出或者隐藏时，对历史记录tableView做相应操作
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.title = @"地图";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClick)];
	
}

- (void)setupData
{
    //假地址
	for (int i =0; i<30; i++) {
		[self.historyAddressM addObject:[NSString stringWithFormat:@"历史地址%d",i]];
	}
}

- (void)keyBoardWillShow:(NSNotification *)note
{
    self.searchHistoryTableView.hidden = NO;
	
	CGFloat duaration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
	CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

	CGFloat searchHistoryTableViewX = 0;
	CGFloat searchHistoryTableViewY = CGRectGetMaxY(self.searchBar.frame);
	CGFloat searchHistoryTableViewW = MainWidth;
	CGFloat searchHistoryTableViewH = ScreenHeight - keyboardF.size.height -self.searchBar.frame.size.height;
	self.searchHistoryTableView.frame = CGRectMake(searchHistoryTableViewX, searchHistoryTableViewY, searchHistoryTableViewW, searchHistoryTableViewH);
	[self.searchHistoryTableView reloadData];
		[UIView animateWithDuration:duaration animations:^{

			[self.navigationController setNavigationBarHidden:YES animated:YES];
			[UIApplication sharedApplication].statusBarHidden = YES;
			
	}];
	
}

- (void)keyBoardWillHide:(NSNotification *)note
{
    self.searchHistoryTableView.hidden = YES;
	CGFloat duaration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
	[UIView animateWithDuration:duaration animations:^{
		[self.navigationController setNavigationBarHidden:NO animated:YES];
		[UIApplication sharedApplication].statusBarHidden = NO;
	}];
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
	if(self.searchBar.text.length > 0)
	{
		__weak __typeof(self)weakSelf = self;
		dispatch_queue_t concurrentQueue = dispatch_queue_create("getGeocodeWithAddress.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
		dispatch_async(concurrentQueue, ^(){
			[weakSelf getGeocodeWithAddress:weakSelf.searchBar.text];
		});
		
	}
}

//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

//文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if(searchText.length > 0)
	{
		[self.alternativeAddressesM removeAllObjects];
		[self.searchHistoryTableView reloadData];
		__weak __typeof(self)weakSelf = self;
		dispatch_queue_t concurrentQueue = dispatch_queue_create("getGeocodeWithAddress.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
		dispatch_async(concurrentQueue, ^(){
			[weakSelf getGeocodeWithAddress:weakSelf.searchBar.text];
		});
		
	}
}

#pragma mark tableView代理

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MainWidth, 44.0)];
	
    UILabel * headerLabel            = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor      = [UIColor clearColor];
    headerLabel.opaque               = NO;
    headerLabel.textColor            = [UIColor colorWithRed:0.275 green:0.498 blue:0.933 alpha:1.000];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font                 = [UIFont boldSystemFontOfSize:16];
	
	CGFloat headerLabelX = 10.0;
	if(isNotiPhone6Plus){
		headerLabelX = 15.0;
	}else{
		headerLabelX = 20.0;
	}
	headerLabel.frame                = CGRectMake(headerLabelX, 0.0, MainWidth, 44.0);
	if(section == 0){
		headerLabel.text             = @"您可能在找";
	}else{
		headerLabel.text             = @"搜索历史";
	}
	[customView addSubview:headerLabel];
	
	return customView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0){
		return self.alternativeAddressesM.count;
	}else{
		return self.historyAddressM.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"historyCell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
	cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor     = [UIColor clearColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
	
	if(indexPath.section == 0)
	{
		//推荐地址
		if(self.alternativeAddressesM.count >0){
			cell.textLabel.text		 = [(CLPlacemark *)self.alternativeAddressesM[indexPath.row] name];
		}
	}else{
		//历史地址
		if(self.historyAddressM.count >0){
			cell.textLabel.text      = self.historyAddressM[indexPath.row];
		}
	}
	
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
    userLocation.title    = @"您的位置";
    userLocation.subtitle = @"您当前所在位置";
	self.userLocation = userLocation;
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    FZ_LOG(@"%f %f", center.latitude, center.longitude);
	
    // 设置地图的中心点（以用户所在的位置为中心点）
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图的显示范围
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    [mapView setRegion:region animated:YES];
}

/**
 *  地理编码
 */
- (void)getGeocodeWithAddress:(NSString *)address {
	if (address.length == 0) return;
	
	__weak __typeof(self)weakSelf = self;
	[self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
		if (error) {
			// 有错误（地址乱输入）
			FZ_LOG(@"没有找到这个地址");
		} else {
			NSMutableArray *distanceArrayM = [NSMutableArray array];
			for (CLPlacemark *pm in placemarks) {
				[weakSelf.alternativeAddressesM addObject:pm];
				double lat = pm.location.coordinate.latitude;
				double lon = pm.location.coordinate.longitude;
				double distance = [weakSelf distanceBetweenOrderBylat1:lat lat2:self.userLocation.coordinate.latitude lon1:lon lon2:self.userLocation.coordinate.longitude];
				[distanceArrayM addObject:[NSNumber numberWithDouble:distance]];
			}
			//排序
			for(int i=0; i<distanceArrayM.count; i++)
			{
				for(int j =i; j<distanceArrayM.count; j++)
				{
					if ([distanceArrayM[i] doubleValue] > [distanceArrayM[j] doubleValue]) {
						[distanceArrayM exchangeObjectAtIndex:i withObjectAtIndex:j];
						[self.alternativeAddressesM exchangeObjectAtIndex:i withObjectAtIndex:j];
					}
				}
			}
			
			for (NSNumber *distance in distanceArrayM) {
				FZ_LOG(@"%@",distance);
			}
			//加载完数据后 刷新表格
			dispatch_async(dispatch_get_main_queue(), ^{
				[weakSelf.searchHistoryTableView reloadData];
			});
			
			// 编码成功
			// 取出最前面的地址
			CLPlacemark *pm = [placemarks firstObject];
			
			// 设置经纬度
			FZ_LOG(@"%@",[NSString stringWithFormat:@"%f", pm.location.coordinate.latitude]);
			FZ_LOG(@"%@",[NSString stringWithFormat:@"%f", pm.location.coordinate.longitude]);
			
			// 设置具体地址
			FZ_LOG(@"%@",pm.name);
			
			NSLog(@"总共找到%ld个地址", placemarks.count);

			for (CLPlacemark *pm in placemarks) {
				NSLog(@"-----地址开始----");

				NSLog(@"%f %f %@", pm.location.coordinate.latitude, pm.location.coordinate.longitude, pm.name);

				[pm.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
					NSLog(@"%@ %@", key, obj);
				}];

				NSLog(@"-----地址结束----");
			}
			
			
		}
	}];
	
	
}

/**
 *  获取两点经纬度地址的方法 返回的单位是公里
 *  @return A，B连点的距离
 */
-(double)distanceBetweenOrderBylat1:(double)lat1 lat2:(double)lat2 lon1:(double)lng1 lon2:(double)lng2{
	double dd = M_PI/180;
	double x1=lat1*dd,x2=lat2*dd;
	double y1=lng1*dd,y2=lng2*dd;
	double R = 6371004;
	double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
	//km  返回
	//     return  distance*1000;
	
	//返回 公里
	return   distance/1000;
 
}

/**
 *  反地理编码
 */
//- (IBAction)getAddressWithGeocode: {
//	// 1.包装位置
//	CLLocationDegrees latitude = [self.latitudeField.text doubleValue];
//	CLLocationDegrees longitude = [self.longtitudeField.text doubleValue];
//	CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//	
//	// 2.反地理编码
//	[self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
//		if (error) { // 有错误（地址乱输入）
//			self.reverseDetailAddressLabel.text = @"你找的地址可能只在火星有！！！";
//		} else { // 编码成功
//			// 取出最前面的地址
//			CLPlacemark *pm = [placemarks firstObject];
//			
//			// 设置具体地址
//			self.reverseDetailAddressLabel.text = pm.name;
//			//            NSLog(@"总共找到%d个地址", placemarks.count);
//			//
//			//            for (CLPlacemark *pm in placemarks) {
//			//                NSLog(@"-----地址开始----");
//			//
//			//                NSLog(@"%f %f %@", pm.location.coordinate.latitude, pm.location.coordinate.longitude, pm.name);
//			//
//			//                [pm.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//			//                    NSLog(@"%@ %@", key, obj);
//			//                }];
//			//
//			//                NSLog(@"-----地址结束----");
//			//            }
//		}
//	}];
//}


//回到用户位置
- (void)backToUserLocation {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}
- (IBAction)tabBarConfirmBtnClick:(UIButton *)sender {
}
@end
