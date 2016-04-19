//
//  AGCitySection.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGCitySection.h"
#import "AGCity.h"
#import "NSObject+Value.h"

@implementation AGCitySection

- (void)setCities:(NSMutableArray *)cities
{
    // 当cities为空或者里面装的是模型数据，就直接赋值
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]){
        _cities = cities;
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        AGCity *city = [[AGCity alloc] init];
        [city setValues:dict];
        [array addObject:city];
    }
    _cities = array;
}

@end
