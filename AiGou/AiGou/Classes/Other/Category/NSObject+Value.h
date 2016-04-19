//
//  NSObject+Value.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//将字典转换成模型

#import <Foundation/Foundation.h>

@interface NSObject (Value)
// 设置数据
- (void)setValues:(NSDictionary *)values;
@end