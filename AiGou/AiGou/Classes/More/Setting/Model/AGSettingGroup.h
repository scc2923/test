//
//  AGSettingGroup.h
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGSettingGroup : NSObject

@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, strong) NSArray *items; // 中间的条目

@end
