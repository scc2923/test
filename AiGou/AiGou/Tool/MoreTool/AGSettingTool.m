//
//  AGSettingTool.m
//  AiGou
//
//  Created by Mac on 15/1/2.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#define AGUserDefaults [NSUserDefaults standardUserDefaults]

#import "AGSettingTool.h"

@implementation AGSettingTool

+ (id)objectForKey:(NSString *)defaultName
{
    return [AGUserDefaults objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [AGUserDefaults setObject:value forKey:defaultName];
    [AGUserDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [AGUserDefaults boolForKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [AGUserDefaults setBool:value forKey:defaultName];
    [AGUserDefaults synchronize];
}

@end
