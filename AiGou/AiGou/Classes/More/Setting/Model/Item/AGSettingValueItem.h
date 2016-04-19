//
//  AGSettingValueItem.h
//  AiGou
//
//  Created by Mac on 15/1/2.
//  Copyright (c) 2015年 AG. All rights reserved.
//  需要存储数据的item都继承自它

#import "AGSettingItem.h"
#import "AGSettingTool.h"

@interface AGSettingValueItem : AGSettingItem

// 存储数据用的key
@property (nonatomic, copy) NSString *key;

@end
