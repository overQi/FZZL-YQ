//
//  SelectMapViewController.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-4-29.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "SelectMapViewController.h"
#import "DXPopover.h"
#import "HP_NavigationController.h"
#import "MBProgressHUD+HP.h"
#import "CommonMapUtility.h"
#import "GeocodeAnnotation.h"
#import "OfflineDetailViewController.h"

@interface SelectMapViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *mapViewContent;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *searchHistoryTableView;//历史记录
@property (nonatomic, strong) IBOutlet UIView *contentView;//容器View。包装searchBar和MapView实现动画上移效果
@property (weak, nonatomic) IBOutlet UIView *buttomTabBar;
@property (weak, nonatomic) IBOutlet UILabel *tabBarLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *historyAddressM;//历史搜索地址
@property (nonatomic, strong) NSMutableArray *tips;		//搜索提示
- (IBAction)tabBarConfirmBtnClick:(UIButton *)sender;
@end

@implementation SelectMapViewController

#pragma mark 生命周期
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setupUI];
	[self setupData];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//键盘呼出或者隐藏时，对历史记录tableView做相应操作
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	//用户位置追踪
//	[self.mapView addObserver:self forKeyPath:@"showsUserLocation" options:NSKeyValueObservingOptionNew context:nil];
	
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	self.mapView.showsUserLocation = YES;
	self.mapView.userTrackingMode  = MAUserTrackingModeFollow;
	[self.mapView setZoomLevel:16.1 animated:YES];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	self.mapView.userTrackingMode  = MAUserTrackingModeNone;
//	[self.mapView removeObserver:self forKeyPath:@"showsUserLocation"];
}

#pragma mark 自定义函数
- (void)setupUI
{
	self.mapView.frame = self.mapViewContent.bounds;
	[self.mapViewContent addSubview:self.mapView];

    self.searchBar.placeholder=@"请输入地址";
    self.searchBar.delegate           = self;
    self.searchBar.showsCancelButton  = YES;
    self.searchBar.keyboardType       = UIKeyboardTypeDefault;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	
    self.searchHistoryTableView.frame           = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), MainWidth, MainHeight - self.searchBar.frame.size.height);
    self.searchHistoryTableView.backgroundColor = [UIColor colorWithWhite:0.435 alpha:0.690];
    self.searchHistoryTableView.delegate        = self;
    self.searchHistoryTableView.dataSource      = self;
    self.searchHistoryTableView.hidden          = YES;
	
    self.title = @"地图";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClick)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"离线地图" style:UIBarButtonItemStyleDone target:self action:@selector(offLineMapButtonClick)];
	
}

- (void)setupData
{
    //假地址
	for (int i =0; i<30; i++) {
		[self.historyAddressM addObject:[NSString stringWithFormat:@"历史地址%d",i]];
	}
}

//点击了取消按钮
- (void)cancelButtonClick
{
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

//点击了离线地图按钮
- (void)offLineMapButtonClick
{
	OfflineDetailViewController *detailViewController = [[OfflineDetailViewController alloc] init];
	detailViewController.mapView = self.mapView;
	detailViewController.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
	
	HP_NavigationController *nav = [[HP_NavigationController alloc] initWithRootViewController:detailViewController];
	
	[self presentViewController:nav animated:YES completion:^{
		
	}];
}

#pragma mark NSKeyValueObservering 键盘
- (void)keyBoardWillShow:(NSNotification *)note
{
	//计算遮盖tableView的尺寸和实现动画效果
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

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//	if ([keyPath isEqualToString:@"showsUserLocation"])
//	{
//		FZ_LOG(@"用户位置改变");
//	}
//}


#pragma mark searchBar代理
//点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
	if(searchBar.text.length == 0)
	{
		[self clear];
		self.tabBarLabel.text = @"请选择地点";
	}
}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	NSString *key = searchBar.text;

	[self clearAndSearchGeocodeWithKey:key adcode:nil];
	self.searchHistoryTableView.hidden = YES;
    [searchBar resignFirstResponder];
}

//文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if(searchText.length > 0)
	{
		[self searchTipsWithKey:searchText];
	}else{
		[self.tips removeAllObjects];
		[self.searchHistoryTableView reloadData];
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
		return self.tips.count;
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
		AMapTip *tip = self.tips[indexPath.row];
		
		cell.textLabel.text = tip.name;
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
	AMapTip *tip = self.tips[indexPath.row];
	
	[self clearAndSearchGeocodeWithKey:tip.name adcode:tip.adcode];
	self.searchHistoryTableView.hidden = YES;
	self.searchBar.text = tip.name;
	[self.searchBar endEditing:YES];
}


- (IBAction)tabBarConfirmBtnClick:(UIButton *)sender {
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	if ([view.annotation isKindOfClass:[GeocodeAnnotation class]])
	{
		
		[self gotoDetailForGeocode:[(GeocodeAnnotation*)view.annotation geocode]];
	}
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
	[self.mapView setCenterCoordinate:[view.annotation coordinate] animated:YES];
	if([[view.annotation title] isEqualToString:@"当前位置"])
	{
		return;
	}
	self.tabBarLabel.text = [view.annotation title];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
	if ([annotation isKindOfClass:[GeocodeAnnotation class]])
	{
		static NSString *geoCellIdentifier = @"geoCellIdentifier";
		
		MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:geoCellIdentifier];
		if (poiAnnotationView == nil)
		{
			poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:geoCellIdentifier];
		}
		
		poiAnnotationView.canShowCallout			= YES;
		poiAnnotationView.animatesDrop              = YES;
		poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		
		return poiAnnotationView;
	}
	
	return nil;
}

#pragma mark - AMapSearchDelegate

/* 地理编码回调.*/
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
	if (response.geocodes.count == 0)
	{
		return;
	}
	
    __block NSMutableArray *annotations = [NSMutableArray array];

	[response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
		GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
		
		[annotations addObject:geocodeAnnotation];
	}];
	
	if (annotations.count == 1)
	{
		[self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
		self.tabBarLabel.text = self.searchBar.text;
	}
	else{
		[self.mapView setVisibleMapRect:[CommonMapUtility minMapRectForAnnotations:annotations] edgePadding:UIEdgeInsetsMake(kMapEdgePadding, kMapEdgePadding, kMapEdgePadding, kMapEdgePadding) animated:YES];
		self.tabBarLabel.text = @"请选择地点";
	}
	[self.mapView addAnnotations:annotations];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
	[self.tips setArray:response.tips];
	[self.searchHistoryTableView reloadData];
}

#pragma mark - Map Utility

/* 地理编码 搜索. */
- (void)searchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode
{
	if (key.length == 0)
	{
		return;
	}
	
	AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
	geo.address = key;
	
	if (adcode.length > 0)
	{
		geo.city = @[adcode];
	}
	
	[self.search AMapGeocodeSearch:geo];
}

/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
	if (key.length == 0)
	{
		return;
	}
	
	AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
	tips.keywords = key;
	[self.search AMapInputTipsSearch:tips];
}

/* 清除annotation. */
- (void)clear
{
	[self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)clearAndSearchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode
{
	/* 清除annotation. */
	[self clear];
	[self searchGeocodeWithKey:key adcode:adcode];
	
}

//跳转到详情控制器
- (void)gotoDetailForGeocode:(AMapGeocode *)geocode
{
	if (geocode != nil)
	{
		//		GeoDetailViewController *geoDetailViewController = [[GeoDetailViewController alloc] init];
		//		geoDetailViewController.geocode = geocode;
		//
		//		[self.navigationController pushViewController:geoDetailViewController animated:YES];
	}
}

#pragma mark 懒加载

- (NSMutableArray *)historyAddressM
{
	if(_historyAddressM == nil)
	{
		_historyAddressM = [NSMutableArray array];
	}
	return _historyAddressM;
}
- (NSMutableArray *)tips
{
	if(_tips == nil)
	{
		_tips = [NSMutableArray array];
	}
	return _tips;
}
@end
