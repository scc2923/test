//
//  AGCity.h
//  AiGou
//
//  Created by rimi on 14/12/24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGBaseModel.h"
#import <CoreLocation/CoreLocation.h>

@interface AGCity : AGBaseModel

@property (nonatomic, strong) NSArray *districts; // 分区
@property (nonatomic, assign) BOOL hot;
@property (nonatomic, assign) CLLocationCoordinate2D position;

@end
