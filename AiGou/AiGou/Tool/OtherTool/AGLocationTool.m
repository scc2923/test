//
//  AGLocationTool.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "AGMetaDataTool.h"
#import "AGCity.h"

@interface AGLocationTool () <CLLocationManagerDelegate>
{
    CLLocationManager *_mgr;
    CLGeocoder *_geo;
}
@end

@implementation AGLocationTool

singleton_implementation(AGLocationTool)


- (id)init
{
    if (self = [super init]) {
        _geo = [[CLGeocoder alloc] init];
        
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
        // 配置位置过滤距离，米为单位。
        _mgr.distanceFilter = kCLDistanceFilterNone;
        // 会弹框显示是否允许您不再使用这个应用的时候仍然获取你得地理位置信息
        [_mgr requestAlwaysAuthorization];
        [_mgr requestWhenInUseAuthorization];
        // 定位精确度最好
        _mgr.desiredAccuracy = kCLLocationAccuracyBest;
        // 开始更新位置
        [_mgr startUpdatingLocation];
    }
    return self;
}

// 当前用户定位授权状态值
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // 判断是否授权定位
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_mgr startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.停止定位
    [_mgr stopUpdatingLocation];
    
    // 2.根据经纬度反向获得城市名称
    CLLocation *loc = locations[0];
    [_geo reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *place = placemarks[0];
         NSString *cityName = place.addressDictionary[@"State"];
          NSLog(@"%@", cityName);
         cityName = [cityName substringToIndex:cityName.length - 1];
         NSLog(@"%@", cityName);
//         AGCity *city = [AGMetaDataTool sharedAGMetaDataTool].totalCities[cityName];
//         [AGMetaDataTool sharedAGMetaDataTool].currentCity = city;
//         
//         _locationCity = city;
//         _locationCity.position = loc.coordinate;
     }];
}

@end
