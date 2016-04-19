//
//  AGCity.m
//  AiGou
//
//  Created by rimi on 14/12/24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGCity.h"
#import "AGDistrict.h"
#import "NSObject+Value.h"

@implementation AGCity

- (void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        AGDistrict *district = [[AGDistrict alloc] init];
        [district setValues:dict];
        [array addObject:district];
    }
    _districts = array;
}

@end
