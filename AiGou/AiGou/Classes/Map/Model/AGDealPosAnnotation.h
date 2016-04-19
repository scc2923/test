//
//  AGDealPosAnnotation.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <MapKit/MapKit.h>

@class AGDeal, AGBusiness;

@interface AGDealPosAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) AGDeal *deal; // 显示的哪个团购
@property (nonatomic, strong) AGBusiness *business; // 显示的是哪个商家
@property (nonatomic, copy) NSString *icon;

@end
