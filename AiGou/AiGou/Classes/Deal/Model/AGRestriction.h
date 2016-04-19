//
//  AGRestriction.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGRestriction : NSObject

@property (nonatomic, assign) BOOL is_reservation_required; // 是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable; // 是否支持随时退款，0：不是，1：是
@property (nonatomic, copy) NSString * special_tips; // （购买须知）附加信息(一般为团购信息的特别提示)

@end
