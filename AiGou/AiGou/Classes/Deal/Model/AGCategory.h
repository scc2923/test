//
//  AGCategory.h
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGBaseModel.h"

@interface AGCategory : AGBaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subcategories;

@end
