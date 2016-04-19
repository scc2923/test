//
//  MapController.m
//  AiGou
//
//  Created by rimi on 14-12-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGMapController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "AGDealPosAnnotation.h"
#import "AGMetaDataTool.h"
#import "AGLocationTool.h"
#import "AGDealTool.h"
#import "AGBusiness.h"
#import "AGDeal.h"

#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)

@interface AGMapController () <MKMapViewDelegate, CLLocationManagerDelegate>
{
    MKMapView * _mapView;
//    CLLocationManager * _locationManager;
    NSMutableArray * _showingDeals;
}

@end

@implementation AGMapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)initUserInterface
{
    self.title = @"地图";
    // 1.初始化数组
    _showingDeals = [NSMutableArray array];
    
    //2.配置用户位置
//    [self addUserLocation];
    [AGLocationTool sharedAGLocationTool];
    // 2.添加地图
    [self addMapView];
    
    // 3.添加回到用户位置的按钮
    [self addUserBackClickLocation];
}

//- (void)addUserLocation
//{
    // 定位授权请求
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    // 配置位置过滤距离，米为单位。
//    _locationManager.distanceFilter = kCLDistanceFilterNone;
//    // 会弹框显示是否允许您不再使用这个应用的时候仍然获取你得地理位置信息
//    [_locationManager requestAlwaysAuthorization];
//    [_locationManager requestWhenInUseAuthorization];
//    // 定位精确度最好
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    // 开始更新位置
//    [_locationManager startUpdatingLocation];
//}

- (void)addUserBackClickLocation
{
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"btn_map_locate.png"];
    [backUser setBackgroundImage:image forState:UIControlStateNormal];
    [backUser setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateNormal];
    CGFloat w = image.size.width/1.5;
    CGFloat h = image.size.height/1.5;
    backUser.frame = CGRectMake(0, self.view.frame.size.height-h-49-64, w, h);
    [backUser addTarget:self action:@selector(backUserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];
}

- (void)addMapView
{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.userTrackingMode = YES;// 跟随模式
    _mapView.mapType = MKMapTypeStandard;// 配置地图显示类型，默认是标准。
    _mapView.showsUserLocation = YES;// 显示用户当前位置
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void)backUserClick
{
    CLLocationCoordinate2D center = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [_mapView setRegion:region animated:YES];
}

 // 当前用户定位授权状态值
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
//    // 判断是否授权定位
//    if (status == kCLAuthorizationStatusAuthorizedAlways ||
//        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [_locationManager startUpdatingLocation];
//    }
//}

#pragma mark - mapView的代理方法
#pragma mark 当定位到用户的位置就会调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_mapView) return;
    // 1.位置（中心点）
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    // 2.跨度（范围）
    //    MKCoordinateSpan span = MKCoordinateSpanMake(0.018404, 0.031468);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    
    // 3.区域
    [mapView setRegion:region animated:YES];
    
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    _mapView = mapView;
}

#pragma mark 拖动地图（地图展示的区域改变了）就会调用
//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // 1.地图当前展示区域的中心位置
    CLLocationCoordinate2D pos = mapView.region.center;
    
    [[AGDealTool sharedAGDealTool] dealsWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (AGDeal *d in deals) {
            // 已经显示过
            if ([_showingDeals containsObject:d]) continue;
            // 从未显示过
            [_showingDeals addObject:d];
            for (AGBusiness *b in d.businesses) {
                AGDealPosAnnotation *anno = [[AGDealPosAnnotation alloc] init];
                anno.business = b;
                anno.deal = d;
                anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:anno];
            }
        }
    } error:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(AGDealPosAnnotation *)annotation
{
    if (![annotation isKindOfClass:[AGDealPosAnnotation class]]) return nil;
    
    // 1.从缓存池中取出大头针view
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    // 2.缓存池没有可循环利用的大头针view
    if (annoView == nil) {
        // 这里应该用MKPinAnnotationView这个子类
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    // 3.设置view的大头针信息
    annoView.annotation = annotation;
    
    // 4.设置图片
    annoView.image = [UIImage imageNamed:annotation.icon];
    
    return annoView;
}

#pragma mark 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    // 1.展示详情
    AGDealPosAnnotation *anno = view.annotation;
    [self showDetail:anno.deal];
    
    // 2.让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    
    // 3.让view周边产生一些阴影效果
    view.layer.shadowColor = [UIColor redColor].CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 10;
}

@end
