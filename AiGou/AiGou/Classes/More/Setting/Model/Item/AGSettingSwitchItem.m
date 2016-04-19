//
//  AGSettingValueItem.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGSettingSwitchItem.h"

@implementation AGSettingSwitchItem

- (void)setOff:(BOOL)off
{
    _off = off;
    
    [AGSettingTool setBool:off forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _off = [AGSettingTool boolForKey:key];
}

@end
