//
//  AGSettingTool.h
//  AiGou
//
//  Created by Mac on 15/1/2.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGSettingTool : NSObject

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

@end

