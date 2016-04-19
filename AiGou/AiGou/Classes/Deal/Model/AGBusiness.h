//
//  AGBusiness.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGBusiness : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;

@end
