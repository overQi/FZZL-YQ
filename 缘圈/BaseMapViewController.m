//
//  BaseMapViewController.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "BaseMapViewController.h"

@implementation BaseMapViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
}

#pragma mark - AMapSearchDelegate

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

#pragma mark - Initialization

- (void)initMapView
{
	self.mapView = [[MAMapView alloc] init];
    self.mapView.delegate = self;
	
}

- (void)initSearch
{
	self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.search.delegate = self;
}

#pragma mark - Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.visibleMapRect = MAMapRectMake(2208801.04, 1014769.80, 2724.96, 4666.56);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[MAMapServices sharedServices].apiKey	= @"5ab783aa034f969a2cceeeda5f10bac4";
	if (IOS8)
	{
		self.locationManager = [[CLLocationManager alloc] init];
		[self.locationManager requestWhenInUseAuthorization];
	}
	

    [self initMapView];
    
    [self initSearch];
}

@end
