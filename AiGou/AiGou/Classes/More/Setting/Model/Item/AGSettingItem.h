//
//  AGSettingItem.h
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSString * const AGID = @"cell";

@interface AGSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) void (^operation)(); // 点击cell后要执行的操作

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (id)itemWithTitle:(NSString *)title;

@end
