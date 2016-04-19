//
//  AGSettingValueItem.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGSettingLabelItem.h"

@implementation AGSettingLabelItem

- (void)setText:(NSString *)text
{
    _text = text;
    
    // 归档
    [AGSettingTool setObject:text forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _text = [AGSettingTool objectForKey:key];
}

@end
